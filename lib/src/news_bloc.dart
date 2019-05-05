import 'dart:async';

import 'package:the_boring_flutter_dev_show/src/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:the_boring_flutter_dev_show/src/data_provider.dart';
import 'dart:collection';


enum StoryType {
  topStories,
  newStories
}

class HackerNewsBloc extends BaseBloc {
  Stream<UnmodifiableListView<Article>> get article => _articleSubject.stream;

  final _articleSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];
  
  Sink<StoryType> get storyTypeSink => storyTypeController.sink;
  
  final storyTypeController = StreamController<StoryType>();

  HackerNewsBloc() {
    getAndUpdateArticles(StoryType.topStories);

    storyTypeController.stream.listen((data) {
      getAndUpdateArticles(data);
    });
  }

  getAndUpdateArticles(StoryType storyType) {
    getListIds(storyType).then((list) {
      getArticles(list).then((_){
        _articleSubject.add(UnmodifiableListView(_articles));
      });
    });
  }

  Future<List<int>> getListIds(StoryType storyType) async {
    final newsIds = await DataProvider().getNewsIds(storyType);
    return newsIds;
  }

  Future<Null> getArticles(List<int> newsIds) async{
    final articleIterable = newsIds.map((id) => getArticle(id));
    final articles = await Future.wait(articleIterable);
    _articles = articles;
  }

  Future<Article> getArticle(int id) async{
    return await DataProvider().getNewsArticle(id);
  }

  @override
  void dispose() {
    _articleSubject.close();
    storyTypeController.close();
  }
}

abstract class BaseBloc {
  void dispose();
}
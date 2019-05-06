import 'package:the_boring_flutter_dev_show/src/article.dart';
import 'package:http/http.dart' as http;
import 'package:the_boring_flutter_dev_show/src/news_bloc.dart';

class DataProvider {
  final newStoryUrl = 'https://hacker-news.firebaseio.com/v0/newstories.json';
  final topStoriesUrl = 'https://hacker-news.firebaseio.com/v0/topstories.json';
  final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/';

  Future<List<int>> getNewsIds(StoryType storyType) async {
    var response;
    if (storyType == StoryType.topStories) {
      response = await http.get(topStoriesUrl);
    } else if (storyType == StoryType.newStories) {
      response = await http.get(newStoryUrl);
    }
    if(response.statusCode == 200) {
      final idList = parseJsonString(response.body);
      return idList;
    } else {
      return [];
    }
  }


  Future<Article> getNewsArticle(int id) async {
    final url = storyUrl + '$id.json';
    final storyResponse = await http.get(url);
    if(storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    } else {
      return null;
    }
  }
}
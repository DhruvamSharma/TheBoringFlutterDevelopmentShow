import 'package:the_boring_flutter_dev_show/src/article.dart';
import 'dart:convert' as json;
import 'package:built_value/built_value.dart';
part 'json_parsing.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  int get id;
  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseJsonString(String jsonString) {
  final parsed = json.jsonDecode(jsonString);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String jsonIdData) {
//  final parsed = json.jsonDecode(jsonIdData);
//  Article article =  Article.fromJson(parsed);
//  return article;
}
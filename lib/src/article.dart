import 'dart:convert' as json;
import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:the_boring_flutter_dev_show/src/serializer.dart';
import 'package:built_value/serializer.dart';
part 'article.g.dart';

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;
  @nullable
  int get id;

  @nullable
  bool get deleted;

  @nullable
  String get type;

  @nullable
  String get by;

  @nullable
  int get time;

  @nullable
  String get text;

  @nullable
  bool get dead;
  @nullable
  int get parent;

  @nullable
  int get poll;

  BuiltList<int> get kids;

  @nullable
  String get url;

  @nullable
  int get score;

  @nullable
  String get title;

  BuiltList<int> get parts;
  @nullable
  int get descendants;
  Article._();
  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
}

List<int> parseJsonString(String jsonString) {
  final parsed = json.jsonDecode(jsonString);
  final listOfIds = List<int>.from(parsed);
  return listOfIds;
}

Article parseArticle(String jsonIdData) {
  final parsed = json.jsonDecode(jsonIdData);
  Article article =  standardSerializers.deserializeWith(Article.serializer, parsed);
  return article;
}
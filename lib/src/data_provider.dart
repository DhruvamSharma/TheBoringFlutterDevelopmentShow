import 'package:the_boring_flutter_dev_show/json_parsing.dart';
import 'package:http/http.dart' as http;

class DataProvider {
  final idUrl = 'https://hacker-news.firebaseio.com/v0/beststories.json';
  final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/';

  Future<List<int>> getNewsIds() async {
    final response = await http.get(idUrl);
    if(response.statusCode == 200) {
      final idList = parseJsonString(response.body);
      return idList;
    }
  }

  Future<Article> getNewsArticle(int id) async {
    final url = storyUrl + '$id.json';
    final storyResponse = await http.get(url);
    if(storyResponse.statusCode == 200) {
      return parseArticle(storyResponse.body);
    }
  }
}
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_post/model/news.dart';

String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=feccf0b302c14390997675979783b001';

Future<News> loadNews() async {
  final response = await http.get(url);
  return newsFromJson(response.body);
}

News newsFromJson(String str) {
  final jsonData = json.decode(str);
  return News.fromJson(jsonData);
}

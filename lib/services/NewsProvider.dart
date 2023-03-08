import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:news_app/model/NewsArticaleModel.dart';

class NewsProvider with ChangeNotifier {
  List<dynamic> _articles = [];
  int _index = 0;

  List<dynamic> get articles => _articles;

  int get index => _index;
  final String api =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7a2210ca89e24d65ae95a55a5c3e9f09";
  final String api2nd =
      "https://newsapi.org/v2/everything?q=apple&from=2023-03-04&to=2023-03-04&sortBy=popularity&apiKey=7a2210ca89e24d65ae95a55a5c3e9f09";
  final String apiInd =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=7a2210ca89e24d65ae95a55a5c3e9f09";
  Future<void> getTopHeadlines() async {
    print("News Provider call");
    final url = api;
    final response = await http.get(Uri.parse(url));
    final jsonData = json.decode(response.body);
    final List<NewsArticle> loadNews = [];
    jsonData["articles"].forEach((article) {
      loadNews.add(NewsArticle(
          title: article["title"],
          description: article['description'],
          author: article['author'],
          url: article['url'],
          urlToImage: article['urlToImage'],
          publishedAt: article['publishedAt'],
          content: article['content']));
    });

    _articles = loadNews;
    notifyListeners();
  }

  void getIndex(int index){
    _index = index;
    notifyListeners();
  }
}

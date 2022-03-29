import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled1/shared/components/constants.dart';

enum NewsApiCallStatus { ok, failed }

class NewsArticle {
  String source = "";
  String author = "";
  String title = "";
  String description = "";
  String url = "";
  String urlToImage = "";
  DateTime publishedAt = DateTime.now();
  String content = "";
  NewsCategories newsCategory = NewsCategories.Any;

  NewsArticle(
      {required this.source,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      this.newsCategory = NewsCategories.Any});

  factory NewsArticle.fromMap(Map mapDataFromJson, [NewsCategories categ = NewsCategories.Any]) {
    //DateFormat format = DateFormat("yyyy-MM-dd:hh:mm");
    var res = mapDataFromJson;
    var elemEntries =
        Map.fromEntries(res.entries.map((e) => MapEntry(e.key, e.value)));
    var dt = DateTime.parse(elemEntries["publishedAt"]);
    return NewsArticle(
        author: (elemEntries["author"] ?? ""),
        content: (elemEntries["content"] ?? ""),
        description: elemEntries["description"],
        publishedAt: dt,
        source: (elemEntries["source"]["name"] ?? ""),
        title: elemEntries["title"],
        url: elemEntries["url"],
        urlToImage: elemEntries["urlToImage"],
        newsCategory: categ);
  }
}

class NewsApiResponse {
  NewsApiCallStatus status = NewsApiCallStatus.failed;
  int totalResults = 0;
  List<NewsArticle> articles = [];

  NewsApiResponse(
      {required this.status,
      required this.articles,
      required this.totalResults});


  factory NewsApiResponse.fromMap(Response<Map> jsonData, [NewsCategories categ = NewsCategories.Any]) {
    var res = jsonData;
    if (res.data == null) {
      return NewsApiResponse(
          status: NewsApiCallStatus.failed, articles: [], totalResults: 0);
    }
    Map reversed = Map.fromEntries(jsonData.data!.entries.map((e) => MapEntry(e.key, e.value)));
    var articles = reversed['articles'] as List<dynamic>;
    List<NewsArticle> articlesMapped = [];
    for (Map mapElem in articles) {
      try {
        articlesMapped.add(NewsArticle.fromMap(mapElem));
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return NewsApiResponse(
        articles: articlesMapped,
        status: (jsonData.statusCode ?? 400) == 200
            ? NewsApiCallStatus.ok
            : NewsApiCallStatus.failed,
        totalResults: jsonData.data!["totalResults"] ?? 0);
  }
}

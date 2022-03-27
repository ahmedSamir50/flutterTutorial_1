
import 'dart:convert';

enum NewsApiCallStatus{
  ok , failed
}
class NewsArticle{
  String source="";
  String author = "";
  String title = "";
  String description = "";
}
class NewsApiResponse{
  NewsApiCallStatus status = NewsApiCallStatus.failed;
  int totalResults=0;
  List articles = [];
  NewsApiResponse({ required this.status , required this.articles , required this.totalResults});

  factory NewsApiResponse.fromJson(Map<String,dynamic>jsonData){
   var res = jsonData;
    return NewsApiResponse(articles: [],  status: NewsApiCallStatus.ok , totalResults: 1);
  }
}
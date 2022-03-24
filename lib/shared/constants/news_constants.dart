// eg : https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=f664b39d32f945c3a0977f4ecda14185";



class NewsConstants{
  static const String baseAPi = "https://newsapi.org";

  static const newsAPIKeyValue = "f664b39d32f945c3a0977f4ecda14185";
  static const newsAPIKeyParam = "apikey";
  static const newsApiCategoryParam = "category";
  static const newsApiCountryParam = "country";
  static const newsApiVersion = "v2";
  static const newsHeadLinesApiRout = "top-headlines";

  static Uri formApiCall({ required String path , required Map<String , dynamic> queryParams  }){
    return Uri(host: baseAPi , path: newsApiVersion +"/"+ path , queryParameters: {...queryParams,newsAPIKeyParam:newsAPIKeyValue});
  }
}
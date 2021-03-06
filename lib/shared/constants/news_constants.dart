// eg : https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=f664b39d32f945c3a0977f4ecda14185";

class NewsConstants {
  static const String baseAPiHost = "newsapi.org";
  static const String baseApiScheme = "https";
  static const newsAPIKeyValue = "f664b39d32f945c3a0977f4ecda14185";
  static const newsAPIKeyValue2 = "dbfe768145b94292a2d8b14c87ac4018";
  static const newsAPIKeyParam = "apikey";
  static const newsApiCategoryParam = "category";
  static const newsApiCountryParam = "country";
  static const newsApiCountryParamEgValue = "eg";
  static const newsApiVersion = "v2";
  static const newsHeadLinesApiRout = "top-headlines";
  static const newsEveryThingApiRout = "everything";
  static const isDarkThemeSharedPrefKey = "isDarkTheme";
  static const userLastPageSharedPrefKey = "userLastPageIdx";

  static Uri formApiCall(
      {required String path, required Map<String, dynamic> queryParams}) {
    var newUri = Uri(
        scheme: baseApiScheme,
        host: baseAPiHost,
        path: newsApiVersion + "/" + path,
        queryParameters: {...queryParams, newsAPIKeyParam: newsAPIKeyValue2});
    return newUri;
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/models/news_api_response.dart';
import 'package:untitled1/modules/newsapp/business.dart';
import 'package:untitled1/modules/newsapp/science.dart';
import 'package:untitled1/modules/newsapp/settings.dart';
import 'package:untitled1/modules/newsapp/sports.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';
import 'package:untitled1/shared/components/constants.dart';
import 'package:untitled1/shared/constants/news_constants.dart';
import 'package:untitled1/shared/helpers/extintions/stringexteintions.dart';
import 'package:untitled1/shared/netwok/remote/dio_Helper.dart';

abstract class INewsAppCubit {
  void changeCurrentViewIndex({int idx});

  void setAppLoadingState();

  Future getNews();

  Widget getCurrentScreen();

  List<Widget> newsScreens = [];
  int currentAppScreenIdx = 0;
  String appTitle = "";
  bool appIsLoading = false;
  bool appHasError = false;
  String appErrorString = "Error";
  NewsApiResponse? newsResults ;
}

class NewsAppCubit extends Cubit<NewsBaseState> implements INewsAppCubit {
  static NewsAppCubit getCubitInstance(BuildContext ctx) => BlocProvider.of(ctx);
  @override
  int currentAppScreenIdx = 0;
  @override
  List<Widget> newsScreens = [];
  @override
  String appTitle = "";
  @override
  bool appIsLoading = false;
  @override
  bool appHasError = false;
  @override
  String appErrorString = "Error";
  @override
  NewsApiResponse? newsResults = NewsApiResponse(
      status: NewsApiCallStatus.failed, totalResults: 0, articles: []);
  final IDioHelper _dioHelper = DioHelper(uriBase: NewsConstants.baseAPiHost);
  bool isFirstCallMade = false;

  NewsAppCubit() : super(NewsInitState()) {
    newsScreens = [
       BusinessScreen(),
       SportsScreen(),
       ScienceScreen(),
       SettingsScreen()
    ];
    appTitle = _setAppTitle();
  }

  String _setAppTitle() => _toggleIconEmoji(getCurrentScreen().runtimeType.toString().replaceAll("Screen", "") + " 📰 News");

  String _toggleIconEmoji(String title) {
    if (title.containsIgnoreCase("business")) {
      title += "💶";
    } else if (title.containsIgnoreCase("science")) {
      title += "🧬";
    } else if (title.containsIgnoreCase("sports")) {
      title += "🏆";
    } else if (title.containsIgnoreCase("settings")) {
      title += "⚙️";
      title = title.replaceAll("📰 News", "");
    } else {
      title += "";
    }
    return title;
  }

  @override
  void changeCurrentViewIndex({int idx = 0}) {
    currentAppScreenIdx = idx;
    isFirstCallMade=false;
    setAppLoadingState();
    emit(ChangeNavBarState());
    setAppLoadingState();
    appTitle = _setAppTitle();
  }

  @override
  void setAppLoadingState() {
    appIsLoading = !appIsLoading;
    emit(AppLoadingState());
  }

  @override
  Widget getCurrentScreen() {
    if(!isFirstCallMade){
      var screen = newsScreens[currentAppScreenIdx].runtimeType.toString();
      var caller = screen.contains("Business")?NewsCategories.Business :
                   screen.contains("Sports")?NewsCategories.Sports:
                   screen.contains("Social")?NewsCategories.Social:
                   NewsCategories.Any;
      isFirstCallMade = true;
      getNews(caller).onError((error, stackTrace) {
        appHasError = true;
        if (kDebugMode) {
        appErrorString = error.toString();
        }
        emit(AppHasErrorState());
      });
    }
    emit(AppChangingScreen());
    return newsScreens[currentAppScreenIdx];
  }

  @override
  Future getNews([NewsCategories categ = NewsCategories.Business]) async {
    setAppLoadingState();
      var queryParams = {
        NewsConstants.newsApiCountryParam:
        NewsConstants.newsApiCountryParamEgValue,
        NewsConstants.newsAPIKeyParam: NewsConstants.newsAPIKeyValue,
      };
        queryParams.addAll({NewsConstants.newsApiCategoryParam :
        categ==NewsCategories.Business?"Business" :
        categ==NewsCategories.Social ? "Social" :
        categ==NewsCategories.Sports ? "Sports" : "any"
        });
      var uri = NewsConstants.formApiCall(
          path: NewsConstants.newsHeadLinesApiRout + "/",
          queryParams:queryParams);
      Response<Map> res = await _dioHelper.getData(uri: uri);
      var dioCall = NewsApiResponse.fromMap(res , categ);
      if (dioCall.totalResults > 0) {
        newsResults =  dioCall ;
      }

    emit(AppGettingNewsState());
    setAppLoadingState();
  }
}

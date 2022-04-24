import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_tutorial_learn1/models/news_api_response.dart';
import 'package:my_flutter_tutorial_learn1/modules/newsapp/business.dart';
import 'package:my_flutter_tutorial_learn1/modules/newsapp/science.dart';
import 'package:my_flutter_tutorial_learn1/modules/newsapp/search.dart';
import 'package:my_flutter_tutorial_learn1/modules/newsapp/settings.dart';
import 'package:my_flutter_tutorial_learn1/modules/newsapp/sports.dart';
import 'package:my_flutter_tutorial_learn1/shared/bloc/newsapp/news_statuses.dart';
import 'package:my_flutter_tutorial_learn1/shared/components/constants.dart';
import 'package:my_flutter_tutorial_learn1/shared/constants/news_constants.dart';
import 'package:my_flutter_tutorial_learn1/shared/dependency_injection.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/cash_helper.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/extintions/stringexteintions.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/helpers.dart';
import 'package:my_flutter_tutorial_learn1/shared/netwok/remote/dio_Helper.dart';

abstract class INewsAppCubit {
  void changeCurrentViewIndex({int idx});

  void setAppLoadingState();

  void toggleAppTheme();

  Future getNews();

  Future getNewsForSearch(String? serchFor);

  Widget getCurrentScreen();

  List<Widget> newsScreens = [];
  int currentAppScreenIdx = 0;
  String appTitle = "";
  bool appIsLoading = false;
  bool appHasError = false;
  String appErrorString = "Error";
  NewsApiResponse? businessNewsResults;
  NewsApiResponse? scienceNewsResults;
  NewsApiResponse? sportsNewsResults;
  NewsApiResponse? searchNewsResults;
  bool isFirstCallMade = false;
  bool appThemeIsDark = true;
  int userLastPage = 0;
}

class NewsAppCubit extends Cubit<NewsBaseState> implements INewsAppCubit {
  static NewsAppCubit getCubitInstance(BuildContext ctx) =>
      BlocProvider.of(ctx);
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
  NewsApiResponse? businessNewsResults = NewsApiResponse(
      status: NewsApiCallStatus.init, totalResults: 0, articles: []);
  @override
  NewsApiResponse? scienceNewsResults = NewsApiResponse(
      status: NewsApiCallStatus.init, totalResults: 0, articles: []);
  @override
  NewsApiResponse? sportsNewsResults = NewsApiResponse(
      status: NewsApiCallStatus.init, totalResults: 0, articles: []);
  @override
  NewsApiResponse? searchNewsResults = NewsApiResponse(
      status: NewsApiCallStatus.init, totalResults: 0, articles: []);
  final IDioHelper _dioHelper = getItDIContainer.get<DioHelper>();
  final ICashHelper _cashHelper = getItDIContainer.get<CashHelper>();
  @override
  bool isFirstCallMade = false;
  @override
  bool appThemeIsDark = false;
  @override
  int userLastPage = 0;

  NewsAppCubit() : super(NewsInitState()) {
    newsScreens = [
      const BusinessScreen(),
      const SportsScreen(),
      const ScienceScreen(),
      const SearchScreen(),
      const SettingsScreen()
    ];
    appTitle = _setAppTitle();

    _cashHelper.getData(NewsConstants.isDarkThemeSharedPrefKey).then((value) {
      appThemeIsDark = (value?.toString() ?? "false") == "true";
    });
    _cashHelper.getData(NewsConstants.userLastPageSharedPrefKey).then((value) {
      userLastPage = int.parse(value.toString(), onError: (value) => 0);
      changeCurrentViewIndex(idx: userLastPage);
    });
    _cashHelper.getAllPrefData().then((value) {
      for (var elem in value) {
        printOnyOnDebugMode(["Here =>>>>>>>> elem "]);
        printOnyOnDebugMode([elem]);
      }
    });
  }

  String _setAppTitle() => _toggleIconEmoji(
      getCurrentScreen().runtimeType.toString().replaceAll("Screen", "") +
          " 📰 News");

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
    isFirstCallMade = false;
    setAppLoadingState();
    _cashHelper.putStringData({
      NewsConstants.userLastPageSharedPrefKey: idx.toString()
    }).then((value) {
      if (idx == 3) {
        searchNewsResults = NewsApiResponse(
            status: NewsApiCallStatus.init, totalResults: 0, articles: []);
      }
      emit(ChangeNavBarState());
      setAppLoadingState();
      appTitle = _setAppTitle();
    });
  }

  @override
  void setAppLoadingState() {
    appIsLoading = !appIsLoading;
    emit(AppLoadingState());
  }

  @override
  Widget getCurrentScreen() {
    var screen = newsScreens[currentAppScreenIdx].runtimeType.toString();
    var caller = getScreenCaller(screen);
    if (!isFirstCallMade) {
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
    queryParams.addAll({
      NewsConstants.newsApiCategoryParam: categ == NewsCategories.Business
          ? "Business"
          : categ == NewsCategories.Social
              ? "Social"
              : categ == NewsCategories.Sports
                  ? "Sports"
                  : categ == NewsCategories.Science
                      ? "Science"
                      : "any"
    });
    var uri = NewsConstants.formApiCall(
        path: NewsConstants.newsHeadLinesApiRout + "/",
        queryParams: queryParams);
    Response<Map> res = await _dioHelper.getData(uri: uri);
    var dioCall = NewsApiResponse.fromMap(res, categ);
    if (dioCall.totalResults > 0) {
      if (categ == NewsCategories.Business) {
        businessNewsResults = dioCall;
      } else if (categ == NewsCategories.Sports) {
        sportsNewsResults = dioCall;
      } else if (categ == NewsCategories.Science) {
        scienceNewsResults = dioCall;
      } else {
        searchNewsResults = dioCall;
      }
    }

    emit(AppGettingNewsState());
    setAppLoadingState();
  }

  @override
  Future getNewsForSearch(String? searchFor) async {
    if (searchFor == null || searchFor.isEmpty) {
      searchNewsResults = NewsApiResponse(
          status: NewsApiCallStatus.init, totalResults: 0, articles: []);
    } else {
      setAppLoadingState();
      var queryParams = {
        "q": searchFor,
        NewsConstants.newsAPIKeyParam: NewsConstants.newsAPIKeyValue,
      };
      var uri = NewsConstants.formApiCall(
          path: NewsConstants.newsEveryThingApiRout + "/",
          queryParams: queryParams);
      Response<Map> res = await _dioHelper.getData(uri: uri);
      var dioCall = NewsApiResponse.fromMap(res, NewsCategories.Any);
      if (dioCall.totalResults > 0) {
        searchNewsResults = dioCall;
      }
      setAppLoadingState();
    }
    emit(AppGettingSearchNewsState());
  }

  @override
  void toggleAppTheme() {
    appThemeIsDark = !appThemeIsDark;
    _cashHelper.putStringData({
      NewsConstants.isDarkThemeSharedPrefKey: appThemeIsDark.toString()
    }).then((value) {
      emit(AppChangeThemeModeState());
    });
  }

  NewsCategories getScreenCaller(screen) {
    return screen.contains("Business")
        ? NewsCategories.Business
        : screen.contains("Sports")
            ? NewsCategories.Sports
            : screen.contains("Social")
                ? NewsCategories.Social
                : screen.contains("Science")
                    ? NewsCategories.Science
                    : NewsCategories.Any;
  }
}

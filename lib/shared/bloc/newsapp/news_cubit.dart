import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled1/models/news_api_response.dart';
import 'package:untitled1/modules/newsapp/business.dart';
import 'package:untitled1/modules/newsapp/science.dart';
import 'package:untitled1/modules/newsapp/settings.dart';
import 'package:untitled1/modules/newsapp/sports.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';
import 'package:untitled1/shared/constants/news_constants.dart';
import 'package:untitled1/shared/dependency_injection.dart';
import 'package:untitled1/shared/helpers/extintions/stringexteintions.dart';
import 'package:untitled1/shared/netwok/remote/dio_Helper.dart';

abstract class INewsAppCubit{
  void changeCurrentViewIndex({int idx});
  void setAppLoadingState();
  Future<Object?> getNews();
  Widget getCurrentScreen();
  List<Widget> newsScreens=[];
  int currentAppScreenIdx=0;
  String appTitle="";
  bool appIsLoading = false;
  List<NewsApiResponse> newsResults = [];
}
class NewsAppCubit extends Cubit<NewsBaseState> implements INewsAppCubit {
  @override
  int currentAppScreenIdx = 0;
  @override
  List<Widget> newsScreens =[];
  @override
  String appTitle = "";
  @override
  bool appIsLoading = false;
  @override
  List<NewsApiResponse> newsResults = [];
  late IDioHelper _dioHelper ;


  NewsAppCubit() : super(NewsInitState()){
    newsScreens =[const BusinessScreen(),const SportsScreen() , const ScienceScreen() , const SettingsScreen()];
    appTitle = _setAppTitle();
    _dioHelper = DioHelper(uriBase: NewsConstants.baseAPiHost);
  }



  String _setAppTitle() => _toggleIconEmoji(getCurrentScreen()
                                              .runtimeType.toString()
                                              .replaceAll("Screen", "")+" 📰 News");
  String _toggleIconEmoji(String title){
    if(title.containsIgnoreCase("business")){
      title +="💶";
    }
    else if(title.containsIgnoreCase("science")){
      title +="🧬";
    }
    else if(title.containsIgnoreCase("sports")){
      title +="🏆";
    }
    else if(title.containsIgnoreCase("settings")){
      title +="⚙️";
      title = title.replaceAll("📰 News", "");
    }
    else {
      title +="";
    }
    return title;
  }

  static NewsAppCubit getCubitInstance(BuildContext ctx)=> BlocProvider.of(ctx);

  @override
  void changeCurrentViewIndex({int idx = 0}) {
    currentAppScreenIdx = idx;
    setAppLoadingState();
    emit(ChangeNavBarState());
    setAppLoadingState();
    appTitle = _setAppTitle();
  }

  @override
  void setAppLoadingState(){
    appIsLoading = !appIsLoading;
    emit(AppLoadingState());
  }

  @override
  Widget getCurrentScreen() {
    return newsScreens[currentAppScreenIdx];
  }

  @override
  Future<Object?> getNews() async{
    // TODO: implement getNews
    setAppLoadingState();
    var dioCall = await _dioHelper.getData<NewsApiResponse>(uri: NewsConstants.formApiCall(
                                                        path: NewsConstants.newsHeadLinesApiRout+"/",
                                                        queryParams: {
                                                          NewsConstants.newsApiCountryParam:NewsConstants.newsApiCountryParamEgValue,
                                                          NewsConstants.newsAPIKeyParam:NewsConstants.newsAPIKeyValue
                                                        }));
    print(dioCall);
    emit(AppGettingNewsState());
    setAppLoadingState();
    return dioCall;
  }






}
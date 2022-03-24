import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/newsapp/business.dart';
import 'package:untitled1/modules/newsapp/science.dart';
import 'package:untitled1/modules/newsapp/settings.dart';
import 'package:untitled1/modules/newsapp/sports.dart';
import 'package:untitled1/shared/bloc/newsapp/news_statuses.dart';
import 'package:untitled1/shared/dependency_injection.dart';
import 'package:untitled1/shared/helpers/extintions/stringexteintions.dart';
import 'package:untitled1/shared/netwok/remote/dio_Helper.dart';

abstract class INewsAppCubit{
  void changeCurrentViewIndex({int idx});
  void setAppLoadingState();
  Widget getCurrentScreen();
  List<Widget> newsScreens=[];
  int currentAppScreenIdx=0;
  String appTitle="";
  bool appIsLoading = false;
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
  late IDioHelper _dioHelper ;

  NewsAppCubit() : super(NewsInitState()){
    newsScreens =[const BusinessScreen(),const SportsScreen() , const ScienceScreen() , const SettingsScreen()];
    appTitle = _setAppTitle();
    _dioHelper = getService<DioHelper>();
  }



  String _setAppTitle() => _toggeleIconEmoji(getCurrentScreen()
                                                          .runtimeType.toString()
                                                          .replaceAll("Screen", "")+" 📰 News");
  String _toggeleIconEmoji(String title){
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






}
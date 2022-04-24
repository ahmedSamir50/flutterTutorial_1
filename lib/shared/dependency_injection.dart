import 'package:get_it/get_it.dart';
import 'package:my_flutter_tutorial_learn1/shared/constants/news_constants.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/cash_helper.dart';
import 'package:my_flutter_tutorial_learn1/shared/netwok/remote/dio_Helper.dart';

final GetIt getItDIContainer = GetIt.instance;
//getService<T>()=> getItDIContainer<T>();

/*
enum InjectionLifeTime{
  singletonLazy,
  singleton ,
  transiant,
  scoped
}
class InjectingModel<IT extends Object>{
  static inject<T extends Object>(InjectionLifeTime lifeTime){
    switch(lifeTime){
      case InjectionLifeTime.singleton:{
        getItDIContainer.registerSingleton<IT>(Type)
      }
    }
  }
}
*/

enum DIApps { ShoppingApp, NewsApp }

class DI {
  void setup(DIApps intForApp) {
    if (intForApp == DIApps.NewsApp) {
      if (!getItDIContainer.isRegistered<DioHelper>()) {
        getItDIContainer.registerSingleton<DioHelper>(
            DioHelper(uriBase: NewsConstants.baseAPiHost));
      }
      if (!getItDIContainer.isRegistered<CashHelper>()) {
        getItDIContainer.registerSingleton<CashHelper>(CashHelper());
      }
    }
    if (intForApp == DIApps.ShoppingApp) {}
    // Alternatively you could write it if you don't like global variables
    //GetIt.I.registerSingleton<AppModel>(AppModel());
  }
}

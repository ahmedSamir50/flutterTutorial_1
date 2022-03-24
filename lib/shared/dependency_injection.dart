import 'package:get_it/get_it.dart';
import 'package:untitled1/shared/netwok/remote/dio_Helper.dart';

final getItDIContainer = GetIt.instance;
getService<T>()=> getItDIContainer<T>();

enum InjectionLifeTime{
  singletonLazy,
  singleton ,
  transiant,
  scoped
}
class InjectingModel<IT,T is IT>{
  static inject(InjectionLifeTime lifeTime){
    switch(lifeTime){
      case InjectionLifeTime.singleton:{
        getItDIContainer.registerSingleton<IType>(Type)
      }
    }
  }
}
class DI {

  void setup() {
    getItDIContainer.registerSingleton<IDioHelper>(DioHelper());

    // Alternatively you could write it if you don't like global variables
    //GetIt.I.registerSingleton<AppModel>(AppModel());
  }
}
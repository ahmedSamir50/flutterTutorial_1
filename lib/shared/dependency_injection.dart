import 'package:get_it/get_it.dart';
import 'package:untitled1/shared/netwok/remote/dio_Helper.dart';

final getItDIContainer = GetIt.instance;
getService<T>()=> getItDIContainer<T>();
class DI {

  void setup() {
    getItDIContainer.registerSingleton<IDioHelper>(DioHelper());

    // Alternatively you could write it if you don't like global variables
    //GetIt.I.registerSingleton<AppModel>(AppModel());
  }
}
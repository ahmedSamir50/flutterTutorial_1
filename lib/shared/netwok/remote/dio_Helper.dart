import 'dart:async';

import 'package:dio/dio.dart';
import 'package:my_flutter_tutorial_learn1/shared/helpers/helpers.dart';

abstract class IDioHelper {
  Future<Response<Map>> getData({required Uri uri});

  Future<Response<Map>> getDataWithPCB(
      {required Uri uri, required ProgressCallback progCallBack});
}

//@Injectable()
class DioHelper implements IDioHelper {
  static Dio _dio = Dio();

  DioHelper({required String uriBase}) {
    init(uriBase: uriBase);
  }

  static init({required String uriBase}) {
    _dio = Dio(BaseOptions(baseUrl: uriBase, receiveDataWhenStatusError: true));
  }

  @override
  Future<Response<Map>> getData({required Uri uri}) async {
    printOnyOnDebugMode(["Calling : " + uri.toString()]);
    try {
      Response<Map> res = await _dio.getUri(uri);
      return res;
    } catch (error) {
      printOnyOnDebugMode(["getData Ran Into Error : " + error.toString()]);
      rethrow;
    }
  }

  @override
  Future<Response<Map>> getDataWithPCB(
      {required Uri uri, required ProgressCallback progCallBack}) async {
    printOnyOnDebugMode(["Calling : " + uri.toString()]);
    try {
      Response<Map> getRes =
          await _dio.getUri(uri, onReceiveProgress: progCallBack);
      return getRes;
    } catch (error) {
      printOnyOnDebugMode(["getData Ran Into Error : " + error.toString()]);
      rethrow;
    }
  }
}

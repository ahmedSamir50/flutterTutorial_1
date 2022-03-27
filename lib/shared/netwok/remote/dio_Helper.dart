import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

abstract class IDioHelper{
  Future<Response> getData<T>({required Uri uri});
  Future<Response<T?>> getDataWithPCB<T>({required Uri uri , required ProgressCallback progCallBack});
}

//@Injectable()
class DioHelper implements IDioHelper {
 static Dio _dio= Dio() ;
 DioHelper({required String uriBase}){
   init(uriBase: uriBase);
 }
 static init({required String uriBase}){
   _dio = Dio(BaseOptions(baseUrl:uriBase , receiveDataWhenStatusError: true));
 }
  @override
  Future<Response> getData<T>({required Uri uri})async{
    var res =  await _dio.getUri( uri);
    return res;
  }

  @override
  Future<Response<T?>> getDataWithPCB<T>({required Uri uri , required ProgressCallback progCallBack})async{
    var getres =  await _dio.get(uri.path ,queryParameters: uri.queryParameters , onReceiveProgress: progCallBack);
     return getres.data;
 }


}
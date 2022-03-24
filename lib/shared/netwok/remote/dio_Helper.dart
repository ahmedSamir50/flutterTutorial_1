import 'package:dio/dio.dart';

abstract class IDioHelper{
  getData({required Uri uri});
  getDataWithPCB({required Uri uri , required ProgressCallback progCallBack});
}

//@Injectable()
class DioHelper implements IDioHelper{

  @override
  Future<Response> getData({required Uri uri})async{
    return await Dio().get(uri.path ,queryParameters: uri.queryParameters);
  }

  @override
  Future<Response> getDataWithPCB({required Uri uri , required ProgressCallback progCallBack})async{
    return await Dio().get(uri.path ,queryParameters: uri.queryParameters , onReceiveProgress: progCallBack);
  }

}
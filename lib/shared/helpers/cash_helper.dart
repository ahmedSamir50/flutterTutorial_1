import 'package:shared_preferences/shared_preferences.dart';

abstract class ICashHelper{
  Future<bool> putStringData(Map<String, String> data);
  Future<Object?> getData(String elemKey);
  Future<List<Map<String,dynamic>>> getAllPrefData();
}
class CashHelper implements ICashHelper{

  Future<SharedPreferences>_getPreference()async{
    return await SharedPreferences.getInstance();
  }

  @override
   Future<bool> putStringData(Map<String, String> data) async {
    try {
      List<bool> allValied = [];
      SharedPreferences sharedPreferences = await _getPreference();
      for(var entry in data.entries){
        allValied.add( await sharedPreferences.setString(entry.key, entry.value) );
      }

      return !allValied.any((element) => element ==false);
    } catch (exp) {
      return false;
    }
  }

  @override
   Future<Object?> getData(String elemKey)  async {
      SharedPreferences sharedPreferences =await   _getPreference();
      return sharedPreferences.get(elemKey);
  }
  @override
  Future<List<Map<String,dynamic>>> getAllPrefData() async{
    SharedPreferences sharedPreferences =await   _getPreference();
    Set sharedPKeys = sharedPreferences.getKeys();
    List<Map<String,dynamic>> allValues =[];
    for (var key in sharedPKeys) {
      allValues.add({key.toString():sharedPreferences.get(key)});
    }
    return allValues;
  }
}
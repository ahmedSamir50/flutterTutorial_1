import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences? sharedPreferences;
  static init () async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putStringData(Map<String, String> data) async {
    try {
      if (sharedPreferences == null) {
        init();
        data.entries.map((e) async {
          await sharedPreferences?.setString(e.key, e.value);
        });
      }
      return true;
    } catch (exp) {
      return false;
    }
  }

  static Object? getData(String elemKey) async {
          return sharedPreferences?.get(elemKey);
  }
}
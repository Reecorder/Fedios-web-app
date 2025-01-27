import 'package:shared_preferences/shared_preferences.dart';

class CookieService {
  //=========================================================================
  // Funtion to  save cookie
  static saveCookie({required String key, required String value}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(key, value);
  }

  //==========================================================================
  // Function to get cookie
  static Future<String?> getCookie({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  //===============================================================================
  // Function to delete cookie
  static deleteCookie({required String key}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }
}

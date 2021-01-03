import 'package:shared_preferences/shared_preferences.dart';

class CacheHandler {
  addStringToCache(String key, String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, string);
  }

  Future<String> getStringFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(key);
    String stringValue = prefs.getString(key);
    print(stringValue);
    return stringValue;
  }
}

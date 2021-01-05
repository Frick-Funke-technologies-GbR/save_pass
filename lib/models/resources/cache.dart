import 'package:shared_preferences/shared_preferences.dart';

class CacheHandler {
  addStringToCache(String key, String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, string);
  }

  addStringListToCache(String key, List<String> stringList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, stringList);
  }

  Future<String> getStringFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(key);
    String stringValue = prefs.getString(key);
    print(stringValue);
    return stringValue;
  }

  Future<List<String>> getStringListFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(key);
    List<String> stringListValue = prefs.getStringList(key);
    print(stringListValue);
    return stringListValue;
  }
}

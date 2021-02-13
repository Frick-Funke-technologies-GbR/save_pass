import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheHandler {

  addSecureStringToCache(String key, String string) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    await storage.write(key: key, value: string);
  }

  addStringToCache(String key, String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, string);
  }

  addStringListToCache(String key, List<String> stringList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, stringList);
  }

  addBoolToCache(String key, bool boolValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, boolValue);
  }

  removeFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<String> getSecureStringFromCache(String key) async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    String stringValue = await storage.read(key: key);
    return stringValue;
  }

  Future<String> getStringFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(key);
    String stringValue = prefs.getString(key);
    // print(stringValue);
    return stringValue;
  }

  Future<List<String>> getStringListFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(key);
    List<String> stringListValue = prefs.getStringList(key);
    // print(stringListValue);
    return stringListValue;
  }

  Future<bool> getBoolFromCache(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool stringListValue = prefs.getBool(key);
    // print(stringListValue);
    return stringListValue;
  }
}

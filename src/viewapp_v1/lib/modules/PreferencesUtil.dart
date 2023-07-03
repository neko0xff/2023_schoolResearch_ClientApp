// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  /*儲存指定字串*/
  static Future<void> saveString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  /*取得指定字串*/
  static Future<String?> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  /*刪除指定字串*/
  static Future<Future<bool>> delString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /*清除所有的資料*/
  static Future<Future<bool>> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

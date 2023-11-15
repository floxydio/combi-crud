import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> setToken(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
    // True / False
  }

  static Future<String> getToken(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }
}

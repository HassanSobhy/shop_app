import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/network/local/pref_keys.dart';

// ignore: avoid_classes_with_only_static_members
class PreferenceUtils {
  static SharedPreferences _prefsInstance;

  static Future<void> setLang(String data) async {
    return _prefsInstance.setString(PrefKeys.LANG, data);
  }

  static Future<String> getLang() async {
    return _prefsInstance.getString(PrefKeys.LANG);
  }

  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await SharedPreferences.getInstance();

    return _prefsInstance;
  }

  static dynamic getData(String key) {
    return _prefsInstance.get(key);
  }

  static Future<bool> setData(String key, dynamic value) async {
    //var prefs = await _instance;
    if (value is String) {
      return await _prefsInstance?.setString(key, value) ?? Future.value(false);
    } else if (value is int) {
      return await _prefsInstance?.setInt(key, value) ?? Future.value(false);
    } else if (value is bool) {
      return await _prefsInstance?.setBool(key, value) ?? Future.value(false);
    } else {
      return await _prefsInstance?.setDouble(key, value) ?? Future.value(false);
    }
  }

  static Future<bool> removeData(String key) async {
    return await _prefsInstance.remove(key);
  }
}

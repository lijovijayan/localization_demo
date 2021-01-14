import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {

  static setI18NVersion(int i18nVersion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('i18nVersion', i18nVersion);
  }

  static getI18NVersion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('i18nVersion')) {
      int i18nVersion = prefs.getInt('i18nVersion');
      return i18nVersion;
    }
    return 0;
  }

}

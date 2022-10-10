import 'package:shared_preferences/shared_preferences.dart';

class AppPref{
  static final AppPref _appPrefs = AppPref._internal();

  factory AppPref() {
    return _appPrefs;
  }

  AppPref._internal();
  late SharedPreferences _prefs;

  Future initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // GETTER

  String get username {
    return _prefs.getString('username')??"";
  }

  String get pass {
    return _prefs.getString('pass')??"";
  }

  String get url {
    return _prefs.getString('url')??"";
  }

  String get rutaPage {
    return _prefs.getString('ruta')??"/";
  }

  String get token {
    return _prefs.getString('token')??"";
  }

  bool get isDarkMode {
    return _prefs.getBool('isDarkMode')??false;
  }

  // SETTER

  set username(String value){
    _prefs.setString('username', value);
  }

  set pass(String value){
    _prefs.setString('pass', value);
  }

  set url(String value){
    _prefs.setString('url', value);
  }

  set rutaPage(String value){
    _prefs.setString('ruta', value);
  }

  set token(String value){
    _prefs.setString('token', value);
  }

  set isDarkMode(bool value){
    _prefs.setBool('isDarkMode', value);
  }
}
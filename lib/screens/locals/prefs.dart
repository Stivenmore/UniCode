import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();

  factory UserPreferences(){
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences? _prefs;

  initPrefs()async{
     this._prefs = await SharedPreferences.getInstance();
  }
 // logout to app
  logout(){
    _prefs!.remove('token');
  }
 // set to token app and save
 set token(String value){
   _prefs!.setString('token', value);
 }
 // get token
 String get token {
   return _prefs!.getString('token')?? '';
 }
 set primary(bool value){
  _prefs!.setBool('primary', value);
 }
 bool get primary {
   return _prefs!.getBool('primary')?? true;
 }
}
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction{
  static String LoggedInkey="ISLOGGEDIN";
  static String UserNamekey="USERNAMEKEY";
  static String UserEmailkey="USEREMAILKEY";

  //saving data

static Future<bool> saveUserLoggedIn(bool isUserLoggedIn) async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  return await prefs.setBool(LoggedInkey, isUserLoggedIn);
}
  static Future<bool> saveUserName(String username) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(UserNamekey, username);
  }
  static Future<bool> saveUserEmail(String email) async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.setString(UserEmailkey, email);
  }


  //Getting Data

  static Future<bool?> getUserLoggedIn() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.getBool(LoggedInkey);
  }

  static Future<String?> getUserName() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.getString(UserNamekey);
  }
  static Future<String?> getUserEmail() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    return await prefs.getString(UserEmailkey);
  }
}
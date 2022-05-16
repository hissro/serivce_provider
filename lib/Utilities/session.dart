//  import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Model/UserModel.dart';
//
// class StorageUtil
// {
//
//    static void saveLogin( UserModel data ) async
//    {
//
//
//      var prefs = await SharedPreferences.getInstance();
//      await prefs.setString("user_id", data.user_id );
//      await prefs.setString("user_fullname", data.user_fullname);
//      await prefs.setString("user_email", data.user_email);
//      await prefs.setString("user_phone", data.user_phone);
//      await prefs.setBool("isLogin", true);
//
//    }
//
//
//    static Future<dynamic>  Loginout(  ) async
//    {
//
//      var prefs = await SharedPreferences.getInstance();
//      await prefs.setBool("isLogin", false);
//      await prefs.setString("user_id", "");
//      await prefs.setString("user_fullname", "");
//      await prefs.setString("user_email", "");
//      await prefs.setString("user_phone", "");
//      return true ;
//
//    }
//
//
//    static Future<dynamic> getLoginInfo() async
//    {
//      var prefs = await SharedPreferences.getInstance();
//      UserModel user =  UserModel (
//        user_id: prefs.getString("user_id").toString(),
//        user_fullname: prefs.getString("user_fullname").toString() ,
//        user_email: prefs.getString("user_email").toString() ,
//        user_phone: prefs.getString("user_phone").toString() ,
//        IsLogin: true
//      );
//        return user;
//    }
//
//    // ignore: non_constant_identifier_names
//    static Future<UserModel>  Userinfo() async
//    {
//      var prefs = await SharedPreferences.getInstance();
//      UserModel user =  UserModel (
//          user_id: prefs.getString("user_id").toString(),
//          user_fullname: prefs.getString("user_fullname").toString() ,
//          user_email: prefs.getString("user_email").toString() ,
//          user_phone: prefs.getString("user_phone").toString() ,
//          IsLogin: true
//      );
//      return user;
//    }
//
//
//    static Future<dynamic> getLogin() async
//    {
//      var prefs = await SharedPreferences.getInstance();
//      return prefs.getBool("isLogin") ?? false;
//    }
//
//
//
//
//
//
//
//    /************* Onboarding ****************/
//    static Future<dynamic> getOnboarding() async
//    {
//      var prefs = await SharedPreferences.getInstance();
//      return prefs.getBool("onboarding") ?? false;
//    }
//
//    static void  setOnboarding(bool onboarding) async
//    {
//      var prefs = await SharedPreferences.getInstance();
//      await prefs.setBool("onboarding", onboarding );
//    }
//
//
//
//
//
// }
//
//
//
//
//

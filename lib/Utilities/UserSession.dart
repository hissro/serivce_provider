import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../DataModels/UserModel.dart';


class UserSession extends GetxController
{
  final session = GetStorage();
  bool IsLogin = false ;
  String UserType = "0" ;
  String title = "اويزو";
  String subtitle = "ايزو للخدمات";
  String profilepc = "assets/images/logo.png";

  var user ;


  @override
  void onInit()
  {
    // TODO: implement onInit
    super.onInit();

    IsLogin =  session.read("IsLogin") == null ?  false : session.read("IsLogin");
    UserType =  session.read("user_type_id") == null ?  "2" : session.read("user_type_id");


    if (IsLogin)
    {
      user = UserInfo();
      title = IsLogin ? session.read("user_fullname") : "AWEZO";
      subtitle = IsLogin ? session.read("user_email") : "ايزو للخدمات";
      profilepc = "assets/images/profile.png";
    }
  }



  void SetUserInfo (UserModel User)
  {
    session.write("user_id", User.user_id);
    session.write("user_fullname", User.user_fullname);
    session.write("user_email", User.user_email);
    session.write("user_phone", User.user_phone);
    session.write("user_type_id", User.user_type_id);
    session.write("IsLogin", true);
  }



  Future<UserModel> getUserInfo() async
   {

      return UserModel(
         user_id:  session.read("user_id"),
         user_fullname: session.read("user_fullname"),
         user_email: session.read("user_email"),
         user_phone: session.read("user_phone") ,
          user_type_id: session.read("user_type_id") ,
         IsLogin: session.read("IsLogin")
     );
   }


  UserModel UserInfo()
  {

    return UserModel(
        user_id:  session.read("user_id"),
        user_fullname: session.read("user_fullname"),
        user_email: session.read("user_email"),
        user_phone: session.read("user_phone") ,
        user_type_id: session.read("user_type_id") ,
        IsLogin: session.read("IsLogin")
    );
  }


  Future<bool> IsUserLogin() async
  {
     return session.read("IsLogin") == null ?  false : session.read("IsLogin");
  }



  void LogOut (   )
  {
    session.write("user_id", null);
    session.write("user_fullname", null);
    session.write("user_email", null);
    session.write("user_phone",  null );
    session.write("IsLogin", false);

    print ('session Log Out : ${session.read("user_fullname")} ');
  }





}
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Categories/Categories.dart';
import '../DataModels/UserModel.dart';
import '../Onboarding/Onboarding.dart';
import '../Utilities/Config.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/network_util.dart';



class SplashController extends GetxController
{
  final session = GetStorage();
  // var UserCont = Get.put(UserController()) ;
  NetworkUtil _netUtil = new NetworkUtil();
  UserSession UControl = Get.put(UserSession()) ;


  @override
  void onInit()
  {
    // TODO: implement onInit
    LoadData();
    super.onInit();
  }


  void LoadData ()
  {
    if ( session.read('IsOnBord') != null  )
    {

      if (session.read('IsOnBord') == true )
      {
        Future.delayed(const Duration(seconds: 3), ()
        {

          ceak_user_type ();
          // Get.to(() => Categories());
        });
      }
      else
      {
        Future.delayed(const Duration(seconds: 3), ()
        {
          Get.offAll(() => const Onboarding());
        });
      }
    }
    else
    {
      session.write('IsOnBord', true) ;
      session.save();
      Future.delayed(const Duration(seconds: 3), ()
      {
        Get.offAll(() => const Onboarding());
      });
    }
  }


  void ceak_user_type ()
  {

    var user_id = session.read("user_id");
    if (user_id != null )
      {
        _netUtil.post(Config.CheakType, body:  {  "user_id": user_id }).then((dynamic res)
        {

          if (res["responce"])
          {
            UserModel user = UserModel.fromJson(res["data"]);
            UControl.SetUserInfo(user);
            UControl.SetUserType (user.user_type_id);
             Future.delayed(const Duration(seconds: 1), ()
            {
              Get.offAll( ()=> Categories());
            });
          }
        }, onError: (e)
        {
          print (e);
        });
      }else
        {
          Future.delayed(const Duration(seconds: 3), ()
          {
            Get.offAll( ()=> Categories());
          });
        }



  }


}


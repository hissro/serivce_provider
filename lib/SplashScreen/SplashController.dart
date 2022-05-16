
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Onboarding/Onboarding.dart';



class SplashController extends GetxController
{
  final session = GetStorage();
  // var UserCont = Get.put(UserController()) ;

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
        print (' On int ');

        // Get.offAll(() => Onboarding());
        // Get.offAll(()=> Categories());
        // Get.offAll(Categories());
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


}


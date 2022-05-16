import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'LocalStorage.dart';

class AppLanguage extends GetxController
{
  var appLocale = 'ar';
  bool RTL = true;

  @override
  void onInit() async
  {
    // TODO: implement onInit
    super.onInit();
    LocalStorage localStorage = LocalStorage();

    var lang = await localStorage.languageSelected ;

    appLocale = lang.isEmpty? 'ar' : lang;
    if (appLocale == "ar") {
      RTL = true;
    } else {
      RTL = false ;
    }
    update();
    Get.updateLocale(Locale(appLocale));
  }



  void changeLanguage(String type) async
  {
    LocalStorage localStorage = LocalStorage();

    if (appLocale == type)
    {
      return;
    }
    if (type == 'ar')
    {
      appLocale = 'ar';
      localStorage.saveLanguageToDisk('ar');
      RTL = true;
      update();

    } else
      {
      appLocale = 'en';
      localStorage.saveLanguageToDisk('en');
      RTL = false;
      update();

    }
    update();
  }

}
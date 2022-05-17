import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Categories/Categories.dart';
import 'Onboarding/Onboarding.dart';
import 'SplashScreen/SplashScreen.dart';
import 'Utilities/translations/LanguageTranslations.dart';



void main() async
{
  await GetStorage.init();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget
{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LanguageTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en','US'),
      title: 'AppName'.tr,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          fontFamily: "noura"
      ),
      // home:   Onboarding(),
      home:   SplashScreen(),
      getPages:
        [


        GetPage(
          name: '/',
          page: () => Categories(),
          // binding: ControllerBindings(),
        ),

        GetPage(
          name: '/SplashScreen',
          page: () => SplashScreen(),
          // binding: ControllerBindings(),
        ),

        GetPage(
          name: '/Onboarding',
          page: () => Onboarding(),
          // binding: ControllerBindings(),
        ),

        /*
        GetPage(
          name: '/LoginView',
          page: () => LoginView(),
          // binding: ControllerBindings(),
        ),


        GetPage(
          name: '/UserProfile',
          page: () => UserProfile(),
        ),

        GetPage(
          name: '/RequestVacation',
          page: () => RequestVacation(),
        ),

        GetPage(
          name: '/JobInfo',
          page: () => JobInfo(),
        ),

        GetPage(
          name: '/FinancialStatements',
          page: () => FinancialStatements(),
        ),

        GetPage(
          name: '/EmployeeInfo',
          page: () => EmployeeInfo(),
        ),

        GetPage(
          name: '/MyRequests',
          page: () => MyRequests(),
        ),
        */


      ],
    );
  }

}



import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Utilities/translations/AppLanguage.dart';
import 'SplashController.dart';


class SplashScreen extends StatelessWidget
{
  var simplecontroller = Get.put(SplashController());
  var appLang = Get.put(AppLanguage()) ;




  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.white24),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      Image.asset(
                        'assets/images/logo.png',
                        height: size.height * 0.35,
                        width: size.width * 0.55,
                      ),

                      // Image.asset('assets/images/logoTabuk.png'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
//                    CircularProgressIndicator(backgroundColor: Color(0XFFFcc9a34)),

                    SpinKitFadingCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven
                                ? const Color(0xfffcc9a34)
                                : const Color(0xfffcc9a64),
                          ),
                        );
                      },
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    const Text(
                      "الرجاء الانتظار",
                      style: TextStyle(
                          fontFamily: 'noura',
                          color: Color(0xfffcc9a34),
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}




















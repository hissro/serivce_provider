import 'package:flutter/material.dart';
import 'package:serivce/Onboarding/ui_view/slider_layout_view.dart';


class Onboarding extends StatefulWidget
{
  const Onboarding({ Key? key  }) : super(key: key);

  static const String routeName = "Onboarding";
  @override
  _OnboardingState createState() => _OnboardingState();
}


class _OnboardingState extends State<Onboarding> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        child: SliderLayoutView(),
      ),
    );
  }

}

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serivce/Utilities/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              login ?   "app.No_have_Account".tr +" " :  "app.Already_have_account".tr+" ",
              style: TextStyle(color: kTextColor , fontFamily: 'noura',
              ),
            ),
            GestureDetector(
              onTap: press,
              child: Text(
                login ?  ("app.SignUp").tr+" " :  ("app.SignIn").tr+" " ,
                style: TextStyle(
                  fontFamily: 'noura',
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),


      ],
    );
  }
}

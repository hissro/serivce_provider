import 'package:serivce/BusinessDetails/theme/colors/light_colors.dart';
import 'package:flutter/material.dart';


class MyBackButton extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
        child: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
          child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: LightColors.kDarkBlue,
          ),
        ),
      ),
    );
  }
}
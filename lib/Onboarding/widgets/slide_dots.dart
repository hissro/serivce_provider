import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive ? 10 : 6,
      width: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Constants.primery,
        border: isActive ?  Border.all(color: Constants.secondary ,width: 2.0,) : Border.all(color: Colors.transparent,width: 1,),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

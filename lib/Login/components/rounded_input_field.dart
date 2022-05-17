import 'package:serivce/Login/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:serivce/Login/components/text_field_container.dart';
import 'package:serivce/Utilities/constants.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  TextEditingController? controllerval = TextEditingController();
  final TextInputType? keybord ;

  final ValueChanged<String>? onChanged;

    RoundedInputField(
  {
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
     this.controllerval,
     this.keybord
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: keybord,
        controller: controllerval,
        style: TextStyle(fontFamily: 'noura'),
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'constants.dart';



const kDefaultShadow = BoxShadow(
  offset: Offset(0, 15),
  blurRadius: 27,
  color: Colors.black12, // Black color with 12% opacity
);



void showAlertDialog(BuildContext context, String message)
{
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title:  Text(  'app.Error'.tr  , style: TextStyle( fontFamily: Constants.Noura , color: kSecondaryColor),),
    content: Text('\n$message \n\n' , style: TextStyle( fontFamily: Constants.Noura , ),),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child:  Text( 'app.Ok'.tr , style: TextStyle( fontFamily: Constants.Noura , ), ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


void showSuccessful(BuildContext context, String message)
{
  // set up the AlertDialog
  final CupertinoAlertDialog alert = CupertinoAlertDialog(
    title:   const Text(' '),
    content: Text('\n$message \n\n' , style: TextStyle( fontFamily: Constants.Noura , color: Colors.black)),
    actions: <Widget>[
      CupertinoDialogAction(
        isDefaultAction: true,
        child:  Text(  'app.Ok'.tr  , style: TextStyle( fontFamily: Constants.Noura , color: kPrimaryColor),),
        onPressed: () {
          Navigator.of(context).pop();
        },
      )
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

bool showLogin ()
{


  return  false ;

}
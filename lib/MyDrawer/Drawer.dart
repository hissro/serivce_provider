import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:serivce/Utilities/UserSession.dart';
import 'package:serivce/Utilities/translations/AppLanguage.dart';

import '../Categories/Categories.dart';
import '../Login/Screens/Login/login_screen.dart';
import '../MyOrder/MyOrder.dart';
import '../MyStore/MyStore.dart';
import '../UserProfile/UserProfile.dart';
import '../Utilities/constants.dart';
import '../settings/settings.dart';

 
class MyDrawer extends StatefulWidget
{
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer>
{

  UserSession UserInfo = Get.put(UserSession()) ;
  var appLang = Get.put(AppLanguage());
  var title = "AWEZO";



  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    _getuser();
    _getLang ();
    setState(() {
      title = UserInfo.title;
    });

  }




  void _getuser ()
  {
    // StorageUtil.getLoginInfo().then((info)
    // {
    //   UserModel myuser  = info;
    //   if (myuser.user_id != "" || myuser.user_id.isNotEmpty)
    //   {
    //      setState(() {
    //        IsLogin = true ;
    //        User = info;
    //      });
    //   }
    //   else
    //     {
    //       setState(() {
    //         IsLogin = false ;
    //       });
    //     }
    // });
  }


  void _getLang () async
  {

    // final preferences = await SharedPreferences.getInstance();
    // var locale = preferences.getString('selected_locale');
    // setState(()
    // {
    //   if(preferences.containsKey('selected_locale'))
    //   {
    //     if ( locale !=  "ar")
    //       {
    //         _RTL = false;
    //       }
    //   }
    // });
  }




  @override
  Widget build(BuildContext context)
  {


    
    return
      ClipRRect(
          borderRadius:
          appLang.RTL == true ?  const BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(220),
        ):  const BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(220),
          ),

      child: SizedBox(
        width: 230,
        child: Drawer(
            elevation: 16,
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: <Widget>
              [


                  UserAccountsDrawerHeader
                  (
                  decoration : BoxDecoration(
                    // color: Colors.blueGrey,
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                      // bottomRight:Radius.circular(70),
                    ),
                  ),


                  accountEmail: Text( UserInfo.subtitle , style: TextStyle(fontFamily: 'noura'  ,color: Colors.white , fontSize: 12) ), //home_info.bus_email
                   accountName: Text(  UserInfo.title ,   style: TextStyle(fontFamily: 'noura' , color: Colors.white  , fontSize: 18 , fontWeight: FontWeight.bold)  ), //home_info.bus_title
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    backgroundImage:  AssetImage("assets/images/profile.png"),
                    backgroundColor: Colors.grey,
                  ),
                ),

                ListTile(
                  leading: const Icon(Icons.home, color: kPrimaryColor ),
                  title: const Text(
                    '????????????????',
                    style: TextStyle(fontFamily: 'noura'),
                  ),
                  onTap: ()
                  {
                    Get.to(()=> Categories());
                    // Navigator.pushReplacementNamed(context, Categories.routeName);
                  },
                ),


                !UserInfo.IsLogin ?   ListTile(
                  leading: const Icon(Icons.lock, color: kPrimaryColor),
                  title: const Text( ('????????'),
                      style: TextStyle(fontFamily: 'noura')),
                  onTap: ()
                  {

                    Get.offAll(() =>  LoginScreen());
                    // Navigator.pushReplacementNamed(context, LoginScreen.routeName);

                  },
                ): Container(),


                UserInfo.IsLogin ?
                ListTile(
                  leading: const Icon(Icons.person , color: kPrimaryColor,),
                  title: const Text(('?????????? ????????????') ,style: TextStyle(fontFamily: 'noura')),
                  onTap: () {
                    Get.to(()=> UserProfile());
                    // Navigator.pushReplacementNamed(context, UserProfile.routeName);
                  },
                ) :Container(),


                UserInfo.IsLogin   ?
                ListTile(
                  leading: const Icon(Icons.favorite_border , color: kPrimaryColor,),
                  title:   Text(('????????????' ) ,style: TextStyle(fontFamily: 'noura')),
                  onTap: () {
                    Get.to(()=>MyOrder());
                    // Navigator.pushReplacementNamed(context, MyBooking.routeName);
                  },
                ) :Container(),


                UserInfo.IsLogin   ?
                UserInfo.UserType == "3" ?
                ListTile(
                  leading: const Icon(Icons.storefront , color: kPrimaryColor,),
                  title: const Text(('??????????') ,style: TextStyle(fontFamily: 'noura')),
                  onTap: () {
                    Get.to(()=>MyStore());
                    // Navigator.pushReplacementNamed(context, MyBooking.routeName);
                  },
                ):Container() :Container(),





                // const ListTile(
                //   leading: Icon(Icons.language, color: kPrimaryColor ),
                //   title: Text( ('??????????'),
                //       style: TextStyle(fontFamily: 'noura')),
                //   // onTap: () => _onActionSheetPress(context),
                // ),

                // ListTile(
                //   leading: const Icon(Icons.share, color: kPrimaryColor),
                //   title: const Text( ('???? ??????????????'),
                //       style: TextStyle(fontFamily: 'noura')),
                //   onTap: () {
                //     // Navigator.of(context).pushReplacementNamed("LoginModel");
                //   },
                // ),


                ListTile(
                  leading: const Icon(Icons.settings_rounded, color: kPrimaryColor),
                  title: const Text( ('??????????????????'),
                      style: TextStyle(fontFamily: 'noura')),
                  onTap: () {
                    // Navigator.of(context).pushReplacementNamed("LoginModel");
                    Get.to(()=> settings());
                  },
                ),

                UserInfo.IsLogin   ?
                ListTile(
                  leading: const Icon(Icons.lock, color: kPrimaryColor),
                  title: const Text( ('????????'),
                      style: TextStyle(fontFamily: 'noura')),
                  onTap: ()
                  {

                    UserInfo.LogOut();
                    Get.offAll(()=> Categories());




                  },
                ) : Container(),


              ],
            )
        ),
      ),);
  }

  /*
  void showDemoActionSheet( {required BuildContext context, required Widget child})
  {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value) {
      if (value != null) changeLocale(context, value);
    });
  }

  void _onActionSheetPress(BuildContext context) {
    showDemoActionSheet(
      context: context,
      child: CupertinoActionSheet(
        title: Text(translate('language.selection.title' ), style: TextStyle(fontFamily: 'noura') ),
        message: Text(translate('language.selection.message') ,style: TextStyle(fontFamily: 'noura') ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(translate('language.name.en') , style: TextStyle(fontFamily: 'noura') ),

            onPressed: () {
              setState(() {
                _RTL = false ;
              });
              Navigator.pop(context, 'en_US');


            },
          ),

          CupertinoActionSheetAction(
            child: Text(translate('language.name.ar')  ,style: TextStyle(fontFamily: 'noura')),
            onPressed: ()
            {
              setState(()
              {
                _RTL = true ;
              });
              Navigator.pop(context, 'ar');

            },
          ),

        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(translate('app.cancel') , style: TextStyle(fontFamily: 'noura') ),
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, null),
        ),
      ),
    );
  }
  */

}

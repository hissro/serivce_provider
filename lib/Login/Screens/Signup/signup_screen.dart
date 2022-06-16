import 'package:get/get.dart';
import 'package:serivce/Utilities/constants.dart';
import 'package:serivce/Utilities/network_util.dart';
import 'package:flutter/material.dart';
import 'package:serivce/Login/Screens/Login/login_screen.dart';
import 'package:serivce/Login/Screens/Signup/components/background.dart';
import 'package:serivce/Login/Screens/Signup/components/or_divider.dart';
import 'package:serivce/Login/components/already_have_an_account_acheck.dart';
import 'package:serivce/Login/components/rounded_button.dart';
import 'package:serivce/Login/components/rounded_input_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../Utilities/Config.dart';
import '../../../Utilities/Functions.dart';

class SignUpScreen extends StatefulWidget
{
  static const String routeName = "SignUpScreen";
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{


  final user_fullname = TextEditingController();
  final user_phone = TextEditingController();
  final user_email = TextEditingController();
  final user_password = TextEditingController();



  var isLogin = false;
  NetworkUtil _netUtil = new NetworkUtil();

  bool _obscureText = true;





  Widget _active_showpassword()
  {
    if (_obscureText) {
      return InkWell(
        onTap: () {
          setState(() {
            _obscureText = false;
          });
        },
        child: Icon(
          Icons.visibility,
          color: KBlack,
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          setState(() {
            _obscureText = true;
          });
        },
        child: Icon(
          Icons.visibility_off,
          color: KBlack,
        ),
      );
    }
  }

  @override
  void initState()
  {

  }



  @override
  void dispose()
  {
    // Clean up the controller when the widget is disposed.
    user_fullname.dispose();
    user_phone.dispose();
    user_email.dispose();
    user_password.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


              // SvgPicture.asset(
              //   "assets/icons/signup.svg",
              //   height: size.height * 0.35,
              // ),

              Image.asset('assets/images/logo.png' ,height: size.height * 0.35 , width:size.width *0.55 ,),

              SizedBox(height: size.height * 0.03),

              Text(
                 ('تسجيل مستخدم جديد').tr,
                style: TextStyle(fontWeight: FontWeight.bold , fontFamily: 'noura' , color:kTextColor ),
              ),
              SizedBox(height: size.height * 0.01 ),

              // RoundedInputField(
              //   hintText: translate('app.user_fullname'),
              //   controllerval: name,
              //   keybord : TextInputType.text,
              // ),
              //


              RoundedInputField(
                hintText:  ('الاسم').tr,
                icon: Icons.person ,
                controllerval: user_fullname,
                keybord : TextInputType.number, onChanged: (String value) {  },
              ),


              RoundedInputField(
                icon: Icons.email_outlined ,
                hintText:   'البريد الالكتروني' ,
                controllerval: user_email,
                keybord : TextInputType.text, onChanged: (String value) {  },
              ),


              RoundedInputField(
                icon: Icons.phone_android ,
                hintText:   'رقم الهاتف',
                controllerval: user_phone,
                keybord : TextInputType.number, onChanged: (String value) {  },
              ),



              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.9,
                decoration: BoxDecoration(
                  color: kBlueColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(29),
                ),
                child:   TextField(
                  controller: user_password,
                  obscureText: _obscureText,
                  cursorColor: KBlack,
                  decoration: InputDecoration(
                    hintText:  ('كلمة المرور').tr,
                    hintStyle: TextStyle(fontFamily: 'noura'),
                    icon: Icon(
                      Icons.lock,
                      color: KBlack,
                    ),
                    suffixIcon: _active_showpassword(),
                    border: InputBorder.none,
                  ),
                ),
              ),







              isLogin == true
                  ? SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? Color(0XFFFcc9a34)
                          : Colors.green,
                    ),
                  );
                },
              )
                  : Container(),

              isLogin == true ? Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                    color: Colors.grey,
                    onPressed: (){},
                    child: Text(
                       ('التسجيل').tr,
                      style: TextStyle(color:Colors.black , fontFamily: 'noura'),
                    ),
                  ),
                ),
              ) :
              RoundedButton(
                text:  ('التسجيل')   ,
                press: () {
                  setState(() {
                    isLogin = true;
                  });
                  _regstriration ();
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {


                  Get.to(()=> LoginScreen());

                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return LoginScreen();
                  //     },
                  //   ),
                  // );
                },
              ),
              OrDivider(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SocalIcon(
              //       iconSrc: "assets/icons/facebook.svg",
              //       press: () {},
              //     ),
              //     SocalIcon(
              //       iconSrc: "assets/icons/twitter.svg",
              //       press: () {},
              //     ),
              //     SocalIcon(
              //       iconSrc: "assets/icons/google-plus.svg",
              //       press: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }



  void  _regstriration()
  {



     var fullname =  user_fullname.text;
     var phone =  user_phone.text;
     var email =  user_email.text;
     var password  = user_password.text;

    if ( phone.length > 0 &&  fullname.length > 0 && password != null &&  email.length > 0 )
    {


           _netUtil.post(Config.signup_URL,  body:
        {
          "user_fullname": fullname.toString() ,
          "user_phone":phone.toString(),
          "user_email": email.toString() ,
          "user_password":password.toString()
        }).then((dynamic res)
        {

          print (' Rs :${res} ');

          setState(()
          {
            isLogin = false;
          });

          if (res["responce"] )
          {

            var mesg  =   "مرحب بك:  "  +  fullname.toString() ;


            showAlertDialog(context,mesg );

            Future.delayed(const Duration(seconds: 3), ()
            {
              Get.offAll( ()=> LoginScreen());
            });

          }
          else
            {
              showAlertDialog(context,   'خطا في تسجيل المستخدم الرجاء التواصل مع الدعم الفني'  );
            }

        }, onError: (e)
        {
          setState(()
          {
            isLogin = false;
          });

          // print (e.toString());
          showAlertDialog(context,  'app.connection_erro' );
        });
    } else
      {
      setState(()
      {
        isLogin = false;
      });
      showAlertDialog(context,   'الرجاء تعبئة الحقول' );
    }
  }

}




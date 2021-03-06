import 'package:get/get.dart';
import 'package:serivce/DataModels/UserModel.dart';
import 'package:serivce/Login/components/text_field_container.dart';
import 'package:serivce/Utilities/Config.dart';
import 'package:serivce/Utilities/Functions.dart';
import 'package:serivce/Utilities/UserSession.dart';
import 'package:serivce/Utilities/constants.dart';
import 'package:serivce/Utilities/network_util.dart';
import 'package:flutter/material.dart';
import 'package:serivce/Login/Screens/Login/components/background.dart';
import 'package:serivce/Login/Screens/Signup/signup_screen.dart';
import 'package:serivce/Login/components/already_have_an_account_acheck.dart';
import 'package:serivce/Login/components/rounded_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../Categories/Categories.dart';
  

class LoginScreen extends StatefulWidget
{
  static const String routeName = "LoginScreen";

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}




class _LoginScreenState extends State<LoginScreen>
{

  UserSession UControl = Get.put(UserSession()) ;
  NetworkUtil _netUtil = new NetworkUtil();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _obscureText = true;
  bool isLogin = false;
  bool isUpdateData = false;

  @override
  void initState()
  {

    // TODO: implement initState
    super.initState();

    _email.text = "hissro.2008@gmail.com";
    _password.text = "hissro";


    // hissro@hotmail.com
    // hissro

    _getuser();

  }

  void _getuser ()
  {
    // StorageUtil.getLogin().then((IsLogin)
    // {
    //  if (IsLogin)
    //    {
    //      Navigator.of(context).pushReplacementNamed('Categories');
    //    }
    // });
  }

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
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;

    return new Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.35,
                width: size.width * 0.55,
              ),
              SizedBox(height: 25,),
              Text(
                 ('?????????? ????????').tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: KBlack,
                    fontFamily: 'main'),
              ),

              // SizedBox(height: size.height * 0.11),

              // SizedBox(height: size.height * 0.03),

              SizedBox(height: 5.0),

              // Text(
              //   translate('app.Login'),
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       color: KBlack,
              //       fontFamily: 'noura'),
              // ),

              TextFieldContainer(
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontFamily: 'noura', color: KBlack),
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: KBlack,
                    ),
                    hintText: "???????????? ????????????????????",
                    border: InputBorder.none,
                  ),
                ),
              ),

              TextFieldContainer(
                child: TextField(
                  controller: _password,
                  obscureText: _obscureText,
                  cursorColor: KBlack,
                  decoration: InputDecoration(
                    hintText:  ('???????? ????????????').tr,
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
                      itemBuilder: (BuildContext context, int index)
                      {
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



              RoundedButton(
                text:  ('????????').tr,
                press: () {
                  setState(()
                  {
                    isLogin = true;
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => HomePage()),
                    // );

                    _login();
                  });
                },
              ),


              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),

              //


            ],
          ),
        ),
      ),
    );
  }


  void _login()
  {

    var pass = _password.text;
    var Email = _email.text;

    if (isUpdateData == false)
    {
      if (Email.isNotEmpty)
      {
        if (pass.isNotEmpty)
        {
            _netUtil.post(Config.LOGIN_URL, body:
          {
            "user_email": Email,
            "user_password": pass
          }).then((dynamic res)
          {
                setState(()
                {
                  isLogin = false;
                });

                if (res["responce"])
                  {
                    UserModel user = UserModel.fromJson(res["data"]);

                    UControl.SetUserInfo(user);

                    showSuccessful(context, ' ???????? ???????? :  ${user.user_fullname}');
                    Future.delayed(const Duration(seconds: 3), ()
                    {
                      Get.offAll( ()=> Categories());
                    });
                  }
                else
                  {
                    showAlertDialog(context,"?????? ???? ???????????? ????????????????");
                  }

          }, onError: (e)
          {
            setState(()
            {
              isLogin = false;
            });
            showAlertDialog(context,  ('connection_erro').tr);
          });
          
        }
          else
            {
            setState(()
            {
              isLogin = false;
            });
            showAlertDialog(context,  ('password_require').tr);
          }
      } else
        {
        setState(()
        {
          isLogin = false;
        });
        showAlertDialog(context, ('nID_require').tr);
      }
    }


  }


}






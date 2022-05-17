import 'package:get/get.dart';
import 'package:serivce/Utilities/Config.dart';
import 'package:serivce/Utilities/Functions.dart';
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
  

class SignUpScreen extends StatefulWidget
{
  static const String routeName = "SignUpScreen";
  @override
  _SignUpScreenState createState() => new _SignUpScreenState();
}



class _SignUpScreenState extends State<SignUpScreen>
{


  final idno = TextEditingController();
  final phone = TextEditingController();
  final pass = TextEditingController();
  final repass = TextEditingController();



  var isLogin = false;
  NetworkUtil _netUtil = new NetworkUtil();







  @override
  void initState()
  {

  }



  @override
  void dispose()
  {
    // Clean up the controller when the widget is disposed.
    idno.dispose();
    phone.dispose();
    pass.dispose();
    repass.dispose();

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
                 ('app.SignUp').tr,
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
                hintText:  ('app.ID_No').tr,
                icon: Icons.person ,
                controllerval: idno,
                keybord : TextInputType.number, onChanged: (String value) {  },
              ),

              //
              // RoundedInputField(
              //   icon: Icons.email_outlined ,
              //   hintText: translate('app.user_email'),
              //   controllerval: email,
              //   keybord : TextInputType.text,
              // ),


              RoundedInputField(
                icon: Icons.phone_android ,
                hintText:  ('app.user_phone').tr,
                controllerval: phone,
                keybord : TextInputType.number, onChanged: (String value) {  },
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
                       ('app.Registration').tr,
                      style: TextStyle(color:Colors.black , fontFamily: 'noura'),
                    ),
                  ),
                ),
              ) :
              RoundedButton(
                text:  ('app.Registration') .tr  ,
                press: () {
                  setState(() {
                    isLogin = true;
                  });
                  // _regstriration ();
                },
              ),
              SizedBox(height: size.height * 0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
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


  /*
  Future<Null>  _regstriration()
  {


    var Username  = idno.text;
    var Mobile = phone.text;


    String yearr = _year.text;
    String _month = selectedUser.id.toString();
    if ( selectedUser.id < 9 )  {  _month =  "0"+ _month ;  }

    //  1003019575   01/07/1383  123456
    // nid:1003019575   DOB: 13830701
    // 1018264109



    if (
          Username.length > 0 &&
          Mobile.length > 0 &&
          yearr != null &&
          yearr.length > 0 &&
          _day != null
    )
    {
          var _DOB = yearr + _month + _day;
          // print( '  "Username": $Username , "Mobile":$Mobile, "DOB": $_DOB , "OnlyValidate":true');

        return  _netUtil.post(Config.Register,  body:
        {"Username": Username.toString() , "Mobile":Mobile.toString(), "DOB": _DOB.toString() , "OnlyValidate":"true"  }).then((dynamic res)
        {
          setState(()
          {
            isLogin = false;
          });

          if (res["status"] == 200)
          {
            // Cheak If Data is valid
            var Sms_Code = res["data"];
            Users info = Users("", Username, Mobile , _DOB );


            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpScreen(
                    OTP: Sms_Code,
                    user : info,
                    pageId: "Registration",
                    ),
              ),
            );


          } else if (res["status"] == 102)
          {
            var msg = res["errors"][0]["message"] ?? '  ';
            // print('res $res' );
            showAlertDialog(context, msg);
          }
          else
            {
              showAlertDialog(context,  translate ('app.error_nid'));
            }

        }, onError: (e)
        {
          setState(()
          {
            isLogin = false;
          });

          // print (e.toString());
          showAlertDialog(context, translate('app.connection_erro'));
        });
    } else
      {
      setState(()
      {
        isLogin = false;
      });
      showAlertDialog(context, translate('app.fill_fields'));
    }
  }
   */
}



class Month
{
  const Month(this.id,this.name);
  final String name;
  final int id;
}



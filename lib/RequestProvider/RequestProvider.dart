import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Categories/Categories.dart';
import '../Login/Screens/Login/login_screen.dart';
import '../Login/components/text_field_container.dart';
import '../Model/CategoryModel.dart';
import '../MyDrawer/Drawer.dart';
import '../Utilities/Config.dart';
import '../Utilities/ErrorPage.dart';
import '../Utilities/Functions.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/constants.dart';
import '../Utilities/network_util.dart';
import 'RequestProviderController.dart';

class RequestProvider extends StatefulWidget {
  const RequestProvider({Key? key}) : super(key: key);
  @override
  State<RequestProvider> createState() => _RequestProviderState();
}

class _RequestProviderState extends State<RequestProvider>
{

  /*
    user_id:4
    bus_title:Post MAN Store
    bus_description:This is Post Man Store
    bus_google_street:Ryadh
    bus_latitude:2.1111
    bus_longitude:23.5555
    bus_contact:16077877
    bus_logo:logo.png
    bus_status:0
    city_id:1
    country_id:1
    locality_id:1
    is_trusted:0
    buscat:1
   */

  
  TextEditingController  bus_titleController = TextEditingController();
  TextEditingController  bus_descriptionController = TextEditingController();
  TextEditingController  bus_google_streetController = TextEditingController();
  TextEditingController  bus_contactController = TextEditingController();

  var vcontroller = Get.put(RequestProviderController());
  var Session = Get.put(UserSession()) ;

  late Future _load ;
  bool isLogin = false ;
  final NetworkUtil _netUtil = NetworkUtil();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _load = vcontroller.get_CATEGORY_LIST();
    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('الطلب كمقدم خدمة'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>
            [




              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'الرجاء تعبئة البيانات',
                  style: TextStyle(fontSize: 20),
                ),
              ),

              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: bus_titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'إسم المتجر',
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  // obscureText: true,
                  controller: bus_descriptionController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'الوصف',
                  ),
                ),
              ),

              FutureBuilder<dynamic>(
                  future: _load,
                  builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot)
                  {
                    switch (snapshot.connectionState)
                    {
                      case ConnectionState.waiting:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height / 2),
                            Center(
                              child: SpinKitFadingCircle(
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: index.isEven
                                          ? const Color(0xfffcc9a34)
                                          : Colors.green,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      default:
                        if (snapshot.hasError) {
                          return ErrorPage(Message: "NetworkError");
                        } else {
                          List<Category> info = snapshot.data;


                          return
                            GetBuilder<RequestProviderController>(
                              id: 'aVeryUniqueID', // here// no need to initialize Controller ever again, just mention the type
                              builder: (value) =>

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                      // color: kPrimaryLightColor,
                                      // color: kBlueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                    child: TextFieldContainer(
                                      child: Row(
                                        children: [
                                          Text(
                                            'القسم',
                                            style: TextStyle(
                                                fontFamily: 'noura', color: kPrimaryColor),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          DropdownButton<Category>(
                                            underline: Text(''),
                                            value: vcontroller.seletectd,
                                            onChanged: (newValue)
                                            {
                                              Category x = newValue as Category;
                                              vcontroller.updateval(x);
                                            },
                                            items: snapshot.data
                                                .map<DropdownMenuItem<Category>>((value)
                                            {
                                              return DropdownMenuItem<Category>(
                                                value: value,
                                                child: Container(
                                                  width: size.width - 200,
                                                  child: new Text(value.title,
                                                      style: TextStyle(
                                                          fontFamily: 'noura',
                                                          fontSize: 16,
                                                          color: kPrimaryColor)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                            );
                        }
                    }
                  }),



              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  // obscureText: true,
                  controller: bus_google_streetController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'العنوان',
                  ),
                ),
              ),


              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: bus_contactController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'رقم التواصل',
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),



              !isLogin ?
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('التسجيل'),
                    onPressed: ()=> SaveData(),

                  ),) :
              SpinKitFadingCircle(
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven
                          ?   kPrimaryLightColor
                          : kSecondaryColor,
                    ),
                  );
                },
              ),



            ],
          )),
      drawer: MyDrawer(),
    );
  }


  void SaveData()
  {


    var bus_title = bus_titleController.text;
    var bus_description = bus_descriptionController.text;
    var bus_google_street  = bus_google_streetController.text;
    var bus_contact  = bus_contactController.text;
    var buscat =  vcontroller.seletectd.id;

    setState(() {
      isLogin = true;
    });




      if (bus_title.isNotEmpty)
      {
        if (bus_description.isNotEmpty)
        {
          Session.IsUserLogin ().then((isLoginn)
          {
            if (isLoginn)
            {

              //UserInfo  Session
              Session.getUserInfo().then((user)
              {


                return _netUtil.post(Config.VendorRegistration, body:
                {
                  "user_id":user.user_id.toString(),
                  "bus_title": bus_title,
                  "bus_description": bus_description,
                  "bus_google_street": bus_google_street ,
                  "bus_latitude":"2.1111",
                  "bus_longitude":"23.5555",
                  "bus_contact": bus_contact.toString(),
                  "bus_logo": "",
                  "bus_status":"0",
                  "city_id":"1",
                  "country_id":"1",
                  "locality_id":"1",
                  "is_trusted":"0",
                  "buscat":buscat.toString(),
                }).then((dynamic res)
                {

                  setState(()
                  {
                    isLogin = false;
                  });


                  if (res["responce"])
                  {


                      showSuccessful(context, '  تم إرسال الطلب بنجاح  ');
                      Future.delayed(const Duration(seconds: 3), ()
                      {
                        Get.offAll( ()=> Categories());
                      });
                    }
                    else
                    {
                    setState(()
                    {
                      isLogin = false;
                    });
                      showAlertDialog(context,"خطا في التسجيل");
                    }



                  }, onError: (e)
                  {
                    setState(()
                    {
                      isLogin = false;
                    });
                    showAlertDialog(context,  e.toString()  );
                  });


              });
            }else
            {
              setState(() {
                isLogin = false;
              });

              Get.defaultDialog(
                title: "الرجاء تسجيل الدخول",
                middleText: "",
                content: Column(
                  children:
                  [


                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Text(
                            "الرجاء تسجيل الدخول "
                        ),
                      ),
                    ),



                  ],
                ),
                barrierDismissible: false,
                radius: 30.0,
                confirm:  ElevatedButton(onPressed: ()
                {
                  Get.to(()=>LoginScreen());
                }, child: Text("دخول")),
                cancel: ElevatedButton(onPressed: () {
                  Get.back();
                }, child: Text("إلغاء")),
              );
            }

          });





        }
        else
        {
          setState(()
          {
            isLogin = false;
          });
          showAlertDialog(context,  'الرجاء ادخال الوصف ');
        }
      }
      else {
        setState(() {
          isLogin = false;
        });
        showAlertDialog(context, 'الرجاء إدخال العنوان');
      }
  }


}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:serivce/BusinessDetails/widgets/task_column.dart';
import 'package:serivce/BusinessDetails/widgets/top_container.dart';
import 'package:serivce/Model/BusinessModel.dart';
import 'package:serivce/Model/EmployeeModel.dart';
import 'package:serivce/Model/PhotosModel.dart';
import 'package:serivce/Model/ReviewsModel.dart';
import 'package:serivce/Model/ServicesModel.dart';
import 'package:serivce/MyDrawer/Drawer.dart';
import 'package:serivce/Utilities/Config.dart';
import 'package:serivce/Utilities/FullScreenImage.dart';
import 'package:serivce/Utilities/Functions.dart';
import 'package:serivce/Utilities/constants.dart';
import 'package:serivce/Utilities/network_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Login/Screens/Login/login_screen.dart';
import '../Utilities/UserSession.dart';
import 'theme/colors/light_colors.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class BusinessDetails extends StatefulWidget
{
  static const String routeName = "BusinessDetails";

  // final BusinessModel BusinessInfo;

  const BusinessDetails({Key? key }) : super(key: key);

  @override
  _BusinessDetailsState createState() => _BusinessDetailsState();

}



class _BusinessDetailsState extends State<BusinessDetails>
{


  var args = Get.arguments;
  late BusinessModel BusinessInfo;

  var Session = Get.put(UserSession()) ;



  final NetworkUtil _netUtil = NetworkUtil();
  late Future<List<ServicesModel>>  _FutureServices;
  late Future<List<EmployeeModel>>  _FutureEmps;
  late Future<List<ReviewsModel>>   _FutureReviews;
  late Future<List<PhotosModel>>    _FuturePhotos;

  late  List<ServicesModel> _services = [];
  var booking_button = false ;
  List<EmployeeModel> employes = [];
  int _page = 0;

  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  final reviewController = TextEditingController();

  bool isLogin = false;


  Widget get_page(index)
  {
    switch (index)
    {
      case 0:
        return Tab1();
        break;

      case 1:
        return Tab2();
        break;

      // case 2:
      //   return Tab3();
      //   break;

      case 2:
        return Tab4();
        break;

      case 3:
        return Tab5();
        break;

      default:
        return Container(
          child: Center(child: Text('default index: $index')),
        );
    }
  }

  Future<List<ServicesModel>> get_BUSINESS_SERVICES () async
  {
    List<ServicesModel> servicess = [];


    return _netUtil.post(Config.BUSINESS_SERVICES ,body:
    {
      "bus_id": BusinessInfo.bus_id.toString()
    }).then((dynamic data)
    {
      var responce = data["responce"];
      var infos = data["data"];

      if (responce)
      {
        for (var i in infos)
        {
          var res = ServicesModel.fromJson(i);
          servicess.add(res);
        }
      }

      return servicess;

    }, onError: (e) {
      print(e.toString());
      showAlertDialog(context,  'app.connection_erro'.tr);
      return servicess;
    });
  }


  Future<List<EmployeeModel>> get_employees () async
  {
    List<EmployeeModel> emps = [];


    return _netUtil.post(Config.GET_EMPLOYEE ,body:
    {
      "bus_id": BusinessInfo.bus_id.toString()
    }).then((dynamic data)
    {
      var responce = data["responce"];
      var infos = data["data"];

      if (responce)
      {
        for (var i in infos)
        {
          var res = EmployeeModel.fromJson(i);
          emps.add(res);
        }
      }

      setState(()
      {
        employes = emps;
      });
      return emps;

    }, onError: (e) {
      print(e.toString());
      showAlertDialog(context, 'app.connection_erro'.tr);
      return emps;
    });
  }




  Future<List<ReviewsModel>> get_reviews () async
  {
    List<ReviewsModel> _reviews = [];


    return _netUtil.post(Config.BUSINESS_REVIEWS ,body:
    {
      "bus_id": BusinessInfo.bus_id.toString()
    }).then((dynamic data)
    {
      var responce = data["responce"];
      var infos = data["data"];


      if (responce)
      {
        for (var i in infos)
        {
            var res = ReviewsModel.fromJson(i);
            _reviews.add(res);
        }
      }

      return _reviews;

    }, onError: (e) {
      print(e.toString());
      showAlertDialog(context,'app.connection_erro'.tr);
      return _reviews;
    });
  }


  Future<List<PhotosModel>> get__Photos () async
  {
    List<PhotosModel> _reviews = [];
    return _netUtil.post(Config.BUSINESS_PHOTOS ,body:
    {
      "bus_id": BusinessInfo.bus_id.toString()
    }).then((dynamic data)
    {
      var responce = data["responce"];
      var infos = data["data"];
      if (responce)
      {
        for (var i in infos)
        {
           _reviews.add(PhotosModel.fromJson(i));

        }
      }
      return _reviews;
    }, onError: (e) {
      print(e.toString());
      showAlertDialog(context,  'app.connection_erro'.tr);
      return _reviews;
    });
  }



  @override
  void initState()
  {
      // TODO: implement initState
      super.initState();

      BusinessInfo = args["BusinessInfo"];
      
      _FutureServices = get_BUSINESS_SERVICES() ;
      _FutureEmps = get_employees();
      _FutureReviews = get_reviews();
      _FuturePhotos = get__Photos();
  }

  @override
  void dispose()
  {
    // Clean up the controller when the widget is disposed.
    // reviewController.dispose();
    super.dispose();
  }

  Text subheading(String title)
  {
     return Text(
      title,
      style: const TextStyle(
          color: kPrimaryColor,
          fontSize: 22.0,
          fontFamily: 'noura',
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2),
    );
  }

  static CircleAvatar calendarIcon() {
    return const CircleAvatar(
      radius: 25.0,
      backgroundColor: LightColors.kGreen,
      child: Icon(
        Icons.add_circle_outline,
        size: 20.0,
        color: Colors.white,
      ),
    );
  }


  @override
  Widget build(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      // backgroundColor: LightColors.kLightYellow,
      body: Column(
        children: <Widget>
        [

          TopContainer(
            image: BusinessInfo.bus_logo,
            height: 200,
            width: width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Icon(Icons.menu,  color: LightColors.kDarkBlue, size: 30.0),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.menu_outlined),
                          onPressed: () => _key.currentState!.openDrawer(),
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),

                      // Icon(Icons.double_arrow_outlined,
                      //     color: LightColors.kDarkBlue, size: 25.0),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>
                      [


                        /*
                        CircularPercentIndicator(
                          radius: 90.0,
                          lineWidth: 5.0,
                          animation: true,
                          percent: 0.75,
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: LightColors.kRed,
                          backgroundColor: LightColors.kDarkYellow,
                          center: CircleAvatar(
                            backgroundColor: LightColors.kBlue,
                            radius: 35.0,
                            backgroundImage: AssetImage(
                              'assets/images/profile.png',
                            ),
                          ),
                        ),  */


                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Text(
                                BusinessInfo.bus_title,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'noura',
                                  // color: LightColors.kDarkBlue,
                                  color: Colors.black ,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),

                            const SizedBox(height: 10,),

                            RatingBarIndicator(
                              rating: double.parse(BusinessInfo.total_rating),
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),


                            /*
                              Container(
                              child: Text(
                                "Title s",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ), */

                          ],
                        )
                      ],
                    ),
                  )
                ]),
          ),

          /********************************************************************/
          get_page(_page),
          /********************************************************************/
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        height: 75.0,
        items: const <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.info_outline,
            size: 30,
            color: Colors.white,
          ),
          // Icon(
          //   Icons.person_outline_sharp,
          //   size: 30,
          //   color: Colors.white,
          // ),
          Icon(
            Icons.comment_outlined,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.local_offer_outlined,
            size: 30,
            color: Colors.white,
          ),
        ],
        color: kPrimaryColor,
        buttonBackgroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      drawer: MyDrawer(),
    );
  }





  void Add_New_Review (BuildContext context) async
   {


     Session.IsUserLogin ().then((isLogin)
     {

       if (isLogin)
         {


           //UserInfo  Session
           Session.getUserInfo().then((user)
           {

             print (' user_id: '+user.user_id);
             print (' bus_id: '+BusinessInfo.bus_id);
             print (' user_fullname: '+BusinessInfo.user_fullname);



           // var userId = Infoo.;


           var bus_id = BusinessInfo.bus_id;
           var user_id = user.user_id;
           double rating = 1;



      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('التعليقات',
              style: TextStyle(fontFamily: 'noura', color: kPrimaryColor),),
            content: Container(
              height: 230,
              width: 430,
              child: Column(
                children: [
                  // Text("اضف تعليقك", style: TextStyle(fontFamily: 'noura'),),

                  TextField(
                    controller: reviewController,
                    maxLength: 30,
                    // minLines: 5,
                    decoration: InputDecoration(
                        labelText: 'إضف تعليق',
                        floatingLabelStyle: TextStyle(
                            fontFamily: 'noura', color: Colors.black),
                        prefixStyle: TextStyle(
                            fontFamily: 'noura', color: Colors.black),
                        hintStyle: TextStyle(
                            fontFamily: 'noura', color: Colors.black),
                        labelStyle: TextStyle(
                            fontFamily: 'noura', color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 3, color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(15),
                        )),
                  ),

                  RatingBar.builder(
                    initialRating: 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: Colors.teal,
                        ),
                    onRatingUpdate: (_rating)
                    {
                      setState(() {
                        rating = _rating;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>
            [

              TextButton(
                child: Text("نعم",  style: TextStyle(fontFamily: 'noura', color: Colors.teal),),
                onPressed: ()
                {

                  var comment = reviewController.text;
                  if (comment.isEmpty)
                    {
                      showAlertDialog(context,  " الرجاء نص التعليق");
                    }
                  else
                    {
                     _netUtil.post(Config.ADD_BUSINESS_REVIEWS, body:
                      {
                        "bus_id": bus_id.toString(),
                        "user_id": user_id.toString(),
                        "reviews": comment.toString(),
                        "rating": rating.toString(),
                      }).then((dynamic res)
                      {
                            print ('Rating Respone :: ${res}');
                            reviewController.clear();
                            if (res["responce"])
                              {
                                setState(() {});
                              }
                            else
                              {
                                showAlertDialog(context,"خطا في  إضافة التعليق  ");
                              }
                      }, onError: (e)
                      {
                        print (' OnErro:  ${e}');
                        showAlertDialog(context,  'خطا في الاتصال بالانترنت' );
                      });
                      Navigator.of(context).pop();
                    }
                },
              ),


              TextButton(
                child: Text("إلغاء", style: TextStyle(fontFamily: 'noura'),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

           });
         }else
           {

             Get.defaultDialog(
               title: "الرجاء تسجيل الدخول",
               middleText: "You content goes here...",
               content: Column(
                 children:
                 [


                   Padding(
                     padding: const EdgeInsets.all(7.0),
                     child: Center(
                       child: Text(
                         "الرجاء تسجيل الدخول لاضافة التقييم"
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


  Widget Tab5()
  {
    Size size = MediaQuery.of(context).size;


    return Expanded(
      child: Stack(
          children: <Widget>
          [


               FutureBuilder(
              future:  _FuturePhotos,
              builder: (BuildContext context, AsyncSnapshot<List<PhotosModel>> snapshot)
              {


                switch (snapshot.connectionState)
                {
                     case ConnectionState.waiting:
                     {
                         return Container(
                         margin: const EdgeInsets.only(top: 60),
                         padding: const EdgeInsets.only(right: 15, left: 15),
                         child:  Stack(
                           alignment: Alignment.bottomCenter,
                           children: <Widget>[
                             // Those are our background
                             Container(
                               height: 136,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(22),
                                 color:  kTextColor ,
                                 boxShadow: const [kDefaultShadow],
                               ),
                               child: Container(
                                 margin: const EdgeInsets.only(right: 10),
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(22),
                                 ),
                               ),
                             ),
                             // our product image

                             // Product title and price
                             Positioned(
                               bottom: 0,
                               left: 0,
                               child: SizedBox(
                                 height: 136,
                                 // our image take 200 width, thats why we set out total width - 200
                                 width: size.width ,
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: <Widget>[
                                     const Spacer(),

                                     Center(
                                       child: Text(
                                         'Loading'.tr,
                                         style: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'noura'),
                                       ),
                                     ),
                                     // it use the available space
                                     const Spacer(),

                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                        );
                     }
                  default:
                    if (snapshot.hasError)
                       {
                         return Container(
                           margin: const EdgeInsets.only(top: 60),
                           padding: const EdgeInsets.only(right: 15, left: 15),
                           child:  Stack(
                             alignment: Alignment.bottomCenter,
                             children: <Widget>[
                               // Those are our background
                               Container(
                                 height: 136,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(22),
                                   color:  kTextColor ,
                                   boxShadow: const [kDefaultShadow],
                                 ),
                                 child: Container(
                                   margin: const EdgeInsets.only(right: 10),
                                   decoration: BoxDecoration(
                                     color: Colors.white,
                                     borderRadius: BorderRadius.circular(22),
                                   ),
                                 ),
                               ),
                               // our product image

                               // Product title and price
                               Positioned(
                                 bottom: 0,
                                 left: 0,
                                 child: SizedBox(
                                   height: 136,
                                   // our image take 200 width, thats why we set out total width - 200
                                   width: size.width ,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: <Widget>[
                                       const Spacer(),

                                       Center(
                                         child: Text(
                                            'error'.tr,
                                           style: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'noura'),
                                         ),
                                       ),
                                       // it use the available space
                                       const Spacer(),

                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         );
                       }
                    else
                      {

                        if (snapshot.data!.isNotEmpty )
                        {
                          return SingleChildScrollView(
                            child: Column(
                              children:
                              [

                                Row(
                                  children:
                                  [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: subheading(' العروض   ' ,),
                                    ),
                                  ],
                                ),


                                ListView.builder(
                                    shrinkWrap: true ,
                                    physics: ScrollPhysics(),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, index)
                                    {
                                      var info = snapshot.data![index];

                                      return ProductCard(
                                        itemIndex: index,
                                        product: info,
                                        press: () {},
                                      );
                                    }
                                ),
                              ],
                            ),
                          );
                        }else
                         {
                            return Container(
                              margin: const EdgeInsets.only(top: 60),
                              padding: const EdgeInsets.only(right: 15, left: 15),
                              child:  Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  // Those are our background
                                  Container(
                                    height: 136,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(22),
                                      color:  kTextColor ,
                                      boxShadow: const [kDefaultShadow],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(22),
                                      ),
                                    ),
                                  ),
                                  // our product image

                                  // Product title and price
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    child: SizedBox(
                                      height: 136,
                                      // our image take 200 width, thats why we set out total width - 200
                                      width: size.width ,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Spacer(),

                                          Center(
                                            child: Text(
                                                 'لاتوجد عروض',
                                              style: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'noura'),
                                            ),
                                          ),
                                          // it use the available space
                                          const Spacer(),

                                          /*
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 padding
                          vertical: kDefaultPadding / 4, // 5 top and bottom
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Text(
                          "\$${product.bus_id}",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),*/

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                    }
                }
              },
            ),


          ]
      ),
    );

  }




  Widget Tab4()
  {
    Size size = MediaQuery.of(context).size;

    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subheading(' المراجعات   ' ,),

                      GestureDetector(
                        onTap: ()
                        {
                          Add_New_Review (context);
                        },
                        child: calendarIcon(),
                      ),

                    ],
                  ),



                  FutureBuilder(
                    future:  get_reviews(),
                    builder: (BuildContext context, AsyncSnapshot<List<ReviewsModel>> snapshot)
                    {

                      if (snapshot.hasData )
                      {

                        if (snapshot.data!.length > 0)
                         { return ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext ctx, index)
                            {
                              var info = snapshot.data![index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>
                                  [
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.transparent,
                                      child:  CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: info.user_image,
                                        placeholder: (context, url) => const SpinKitFadingFour(
                                          color: Colors.amber,
                                          size: 50.0,
                                        ),
                                        errorWidget: (context, url, error) => Image.asset("assets/images/profile.png"),
                                      ),
                                      // Image.network(info.user_image  ),
                                    ),
                                    const SizedBox(width: 10.0),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>
                                      [
                                        RatingBarIndicator(
                                          rating: double.parse(info.ratings),
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: kPrimaryColor.withOpacity(0.5),
                                          ),
                                          itemCount: 5,
                                          itemSize: 20.0,
                                          direction: Axis.horizontal,
                                        ),

                                        const SizedBox(height: 5.0),

                                        Text(
                                          info.reviews ,
                                          style: const TextStyle(
                                            fontFamily: 'noura',
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),

                                        Text(
                                          info.user_fullname,
                                          style: const TextStyle(
                                              fontFamily: 'title',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black45),
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          );}
                        else
                        {
                          return Container(
                            margin: const EdgeInsets.only(top: 60),
                            padding: const EdgeInsets.only(right: 15, left: 15),
                            child:  Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                // Those are our background
                                Container(
                                  height: 90,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color:  kTextColor ,
                                    boxShadow: const [kDefaultShadow],
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                  ),
                                ),
                                // our product image

                                // Product title and price
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  top: 0,
                                  child: SizedBox(
                                    height: 136,
                                    // our image take 200 width, thats why we set out total width - 200
                                    width: size.width ,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Spacer(),

                                        Center(
                                          child: Text(
                                            'لاتوجد بيانات',
                                            style: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'noura'),
                                          ),
                                        ),
                                        // it use the available space
                                        const Spacer(),

                                        /*
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 padding
                          vertical: kDefaultPadding / 4, // 5 top and bottom
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Text(
                          "\$${product.bus_id}",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),*/

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                      } else if (snapshot.connectionState == "active" )
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else
                      {
                        return Container();
                      }
                    },
                  ),

                ],
              ),
            ),
            /*
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  subheading('Active Projects'),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kGreen,
                        loadingPercent: 0.25,
                        title: 'Medical App',
                        subtitle: '9 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kRed,
                        loadingPercent: 0.6,
                        title: 'Making History Notes',
                        subtitle: '20 hours progress',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kDarkYellow,
                        loadingPercent: 0.45,
                        title: 'Sports App',
                        subtitle: '5 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kBlue,
                        loadingPercent: 0.9,
                        title: 'Online Flutter Course',
                        subtitle: '23 hours progress',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }


  Widget Tab3()
  {
    Size size = MediaQuery.of(context).size;

    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subheading(' الموظفين   ' ,),
                      /*
                      GestureDetector(
                        onTap: ()
                        {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CalendarPage()),
                          // );
                        },
                        child: calendarIcon(),
                      ),
                      */
                    ],
                  ),



                  FutureBuilder(
                    future:  _FutureEmps,
                    builder: (BuildContext context, AsyncSnapshot<List<EmployeeModel>> snapshot)
                    {
                      if (snapshot.hasData // && snapshot.connectionState == "done" )
                      )
                      {

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext ctx, index)
                          {
                            var info = snapshot.data![index];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 30.0,
                                    backgroundColor: Colors.transparent,
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: info.doct_photo,
                                      placeholder: (context, url) => const SpinKitFadingFour(
                                        color: Colors.amber,
                                        size: 50.0,
                                      ),
                                      errorWidget: (context, url, error) => const Icon(Icons.error , color: Colors.red, size: 30,),
                                    ),
                                    // child:  Image.network(info.doct_photo  ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          info.doct_name,
                                        style: const TextStyle(
                                          fontFamily: 'noura',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                       Text(
                                        info.doct_degree,
                                        style: const TextStyle(
                                            fontFamily: 'title',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black45),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );

                      } else if (snapshot.connectionState == "active" )
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else
                      {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),


            /*
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  subheading('Active Projects'),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kGreen,
                        loadingPercent: 0.25,
                        title: 'Medical App',
                        subtitle: '9 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kRed,
                        loadingPercent: 0.6,
                        title: 'Making History Notes',
                        subtitle: '20 hours progress',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kDarkYellow,
                        loadingPercent: 0.45,
                        title: 'Sports App',
                        subtitle: '5 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kBlue,
                        loadingPercent: 0.9,
                        title: 'Online Flutter Course',
                        subtitle: '23 hours progress',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }



  Widget Tab2()
  {

    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subheading(' عن المتجر ' ,),
                      /*
                      GestureDetector(
                        onTap: ()
                        {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CalendarPage()),
                          // );
                        },
                        child: calendarIcon(),
                      ),
                      */
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  TaskColumn(
                    icon: Icons.info,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'العنوان',
                    subtitle: BusinessInfo.bus_google_street,
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TaskColumn(
                    icon: Icons.phone_android_outlined,
                    iconBackgroundColor: LightColors.kDarkYellow,
                    title: ' الهاتف',
                    subtitle: BusinessInfo.bus_contact,
                  ),
                  const SizedBox(height: 15.0),


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 20.0,
                        backgroundColor: LightColors.kBlue,
                        child: Icon(
                            Icons.check_circle_outline,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'الوصف',
                            style: TextStyle(
                              fontFamily: 'noura',
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),


                        ],
                      )
                    ],
                  ),

                  /*
                  Html(
                    data: """
                          ${BusinessInfo.bus_description}
                          """,
                    customRenders: {
                      " ": (RenderContext context, Widget child) {
                        return TextSpan(text: " ");
                      },
                      "flutter": (RenderContext context, Widget child)
                      {
                        return FlutterLogo(
                          style: (context.tree.element!.attributes['horizontal'] != null)
                              ? FlutterLogoStyle.horizontal
                              : FlutterLogoStyle.markOnly,
                          // textColor: context.style.color,
                          size: context.style.fontSize!.size! * 5,
                        );
                      },
                    },
                    // tagsList: Html.tags..addAll(["bird", "flutter"]),
                  ),

                  */

                ],
              ),
            ),
            /*
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  subheading('Active Projects'),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kGreen,
                        loadingPercent: 0.25,
                        title: 'Medical App',
                        subtitle: '9 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kRed,
                        loadingPercent: 0.6,
                        title: 'Making History Notes',
                        subtitle: '20 hours progress',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kDarkYellow,
                        loadingPercent: 0.45,
                        title: 'Sports App',
                        subtitle: '5 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kBlue,
                        loadingPercent: 0.9,
                        title: 'Online Flutter Course',
                        subtitle: '23 hours progress',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            */
          ],
        ),
      ),
    );
  }



  Widget Tab1()
  {

    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(  horizontal: 20.0, vertical: 30.0),
              child: Column(
                children: <Widget>
                [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0 , left: 12.0),
                        child: subheading('الخدمات'),
                      ),

                      /*
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CalendarPage()),
                          );
                        },
                        child: calendarIcon(),
                      ), */

                    ],
                  ),


                  FutureBuilder(
                    future:  _FutureServices,
                    builder: (BuildContext context, AsyncSnapshot<List<ServicesModel>> snapshot)
                    {
                      if (snapshot.hasData    )
                      {

                        if (snapshot.data!.length > 0)


                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext ctx, index)
                          {

                            double cWidth = MediaQuery.of(context).size.width*0.8;
                            var info = snapshot.data![index];


                            var discount =   int.parse(info.service_discount) == 0 ? '' :  "   (%${info.service_discount} ${'خصم'.tr})  ";

                            // print ('discount  :${discount}');

                            return
                              CheckboxListTile(
                                controlAffinity: ListTileControlAffinity.leading,
                                activeColor: Colors.transparent,
                                checkColor: Colors.teal,
                                title:
                                Container (
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  width: cWidth,
                                  child: Column (
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text (info.service_title+" "+discount, textAlign: TextAlign.start ,style: const TextStyle(fontFamily: 'noura' , fontSize: 14),),
                                    ],
                                  ),
                                ),
                                /*
                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(info.service_title   , style: TextStyle(fontFamily: 'noura' , fontSize: 14),),
                                    Text(   discount , style: TextStyle(fontFamily: 'noura' , fontSize: 12 ),),
                                  ],
                                ),
                                */
                                value: info.isclicked,
                                onChanged: (bool? value)
                                {

                                  setState(()
                                  {
                                    if (info.isclicked == true )
                                    {
                                      info.isclicked = false;
                                    }
                                    else
                                    {
                                      info.isclicked = true;
                                    }
                                    booking_button = true ;
                                    _services = snapshot.data! ;
                                  });
                                },
                                secondary: Text (   info.toutal.toString()+ " "+ 'ريال'.tr  , style: const TextStyle(fontFamily: 'noura' , fontSize: 14),),

                                /*
                                  secondary: CircleAvatar(
                                    radius: 20.0,
                                    backgroundColor: LightColors.kDarkYellow,
                                    child: Icon(
                                      Icons.info_outline,
                                      size: 18.0,
                                      color: Colors.black,
                                    ),
                                  ), */
                              );
                          },
                        );


                        else
                        return Container(
                          margin: const EdgeInsets.only(top: 60),
                          padding: const EdgeInsets.only(right: 15, left: 15),
                          child:  Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              // Those are our background
                              Container(
                                height: 136,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color:  kTextColor ,
                                  boxShadow: const [kDefaultShadow],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              // our product image

                              // Product title and price
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 136,
                                  // our image take 200 width, thats why we set out total width - 200
                                  width: MediaQuery.of(context).size.width ,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Spacer(),

                                      Center(
                                        child: Text(
                                          'لاتوجد خدمات في المتجر',
                                          style: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'noura'),
                                        ),
                                      ),
                                      // it use the available space
                                      const Spacer(),

                                      /*
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: kDefaultPadding * 1.5, // 30 padding
                          vertical: kDefaultPadding / 4, // 5 top and bottom
                        ),
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            topRight: Radius.circular(22),
                          ),
                        ),
                        child: Text(
                          "\$${product.bus_id}",
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),*/

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );

                      } else if (snapshot.connectionState == "active" )
                      {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      else
                      {
                       return Container();
                      }
                    },
                  ),


                  booking_button == true ?
                  !isLogin ?
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                        elevation: 5.0,
                        minWidth: 200.0,
                        height: 35,
                        color: const Color(0xFFfff9ec),
                        child: const Text('طلب', style: TextStyle(fontSize: 16.0, color: Colors.black , fontFamily: "noura")),
                        onPressed: ()
                        {
                          setState(()
                          {
                            isLogin = true;
                            booking (  );
                          });
                        },
                      ),
                    ),
                  ):SpinKitFadingCircle(
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: index.isEven
                              ?   kPrimaryLightColor
                              : kSecondaryColor,
                        ),
                      );
                    },
                  )
                      : Container(),

                  /*
                  SizedBox(height: 15.0),
                  TaskColumn(
                    icon: Icons.alarm,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'To Do',
                    subtitle: '5 tasks now. 1 started',
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TaskColumn(
                    icon: Icons.blur_circular,
                    iconBackgroundColor: LightColors.kDarkYellow,
                    title: 'In Progress',
                    subtitle: '1 tasks now. 1 started',
                  ),
                  SizedBox(height: 15.0),
                  TaskColumn(
                    icon: Icons.check_circle_outline,
                    iconBackgroundColor: LightColors.kBlue,
                    title: 'Done',
                    subtitle: '18 tasks now. 13 started',
                  ),
                  */

                ],
              ),
            ),

          ],
        ),
      ),
    );
  }





  void booking (  )
  {

      List<ServicesModel> Myservices = [];
      String ServiceString ="" ;
      var bus_id = BusinessInfo.bus_id;


      Session.IsUserLogin ().then((isLoginn)
      {
        if (isLoginn)
        {
          Session.getUserInfo().then((user)
          {

            var user_id = user.user_id ;
            var user_fullname = user.user_fullname ;
            var user_email = user.user_email ;
            var user_phone = user.user_phone ;

            for (var ii in _services )
            {
              if (ii.isclicked)
              {
                // print("\nName : ${ii.service_title} ::   Is Choieses ${ii.isclicked} ");
                Myservices.add(ii);
                ServiceString  = ServiceString +  ii.id.toString()+",";
              }
            }



            if ( Myservices.length >0 )
            {

              ServiceString = ServiceString.substring(0, ServiceString.length - 1);
              return _netUtil.post(Config.AddAppointment, body:
              {
                "user_id":user_id.toString(),
                "bus_id":bus_id ,
                "doct_id": "",
                "user_fullname": user_fullname ,
                "user_email": user_email,
                "user_phone":user_phone,
                "services": ServiceString,
              }).then((dynamic res)
              {

                print ('Res :${res}');
                setState(()
                {
                  isLogin = false;
                });


                if (res["responce"])
                {

                  showSuccessful(context, '  تم إرسال الطلب بنجاح  ');
                  Future.delayed(const Duration(seconds: 3), ()
                  {
                    // Get.offAll( ()=> Categories());
                  });
                }
                else
                {
                  setState(()
                  {
                    isLogin = false;
                  });
                  showAlertDialog(context,"خطا في طلب الخدمة");
                }



              }, onError: (e)
              {
                setState(()
                {
                  isLogin = false;
                });
                showAlertDialog(context,  e.toString()  );
              });


            }else
            {
              setState(()
              {
                isLogin = false;
              });
              showAlertDialog (context,"الرجاء اختيار خدمة علي الاقل");
            }



          });
        }
     });



  }


}




/*

 Widget Tab2()
  {
    Size size = MediaQuery.of(context).size;

    return  Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subheading(' التفاصيل ' ,),
                      GestureDetector(
                        onTap: ()
                        {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => CalendarPage()),
                          // );
                        },
                        child: calendarIcon(),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  TaskColumn(
                    icon: Icons.alarm,
                    iconBackgroundColor: LightColors.kRed,
                    title: 'To Do',
                    subtitle: '5 tasks now. 1 started',
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TaskColumn(
                    icon: Icons.blur_circular,
                    iconBackgroundColor: LightColors.kDarkYellow,
                    title: 'In Progress',
                    subtitle: '1 tasks now. 1 started',
                  ),
                  SizedBox(height: 15.0),
                  TaskColumn(
                    icon: Icons.check_circle_outline,
                    iconBackgroundColor: LightColors.kBlue,
                    title: 'Done',
                    subtitle: '18 tasks now. 13 started',
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  subheading('Active Projects'),
                  SizedBox(height: 5.0),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kGreen,
                        loadingPercent: 0.25,
                        title: 'Medical App',
                        subtitle: '9 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kRed,
                        loadingPercent: 0.6,
                        title: 'Making History Notes',
                        subtitle: '20 hours progress',
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ActiveProjectsCard(
                        cardColor: LightColors.kDarkYellow,
                        loadingPercent: 0.45,
                        title: 'Sports App',
                        subtitle: '5 hours progress',
                      ),
                      SizedBox(width: 20.0),
                      ActiveProjectsCard(
                        cardColor: LightColors.kBlue,
                        loadingPercent: 0.9,
                        title: 'Online Flutter Course',
                        subtitle: '23 hours progress',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

 */










class ProductCard extends StatelessWidget
{
  const ProductCard({
    Key? key,
    required this.itemIndex,
    required this.product,
    required this.press,
  }) : super(key: key);

  final int itemIndex;
  final PhotosModel product;
  final Function press;

  @override
  Widget build(BuildContext context)
  {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      // color: Colors.blueAccent,
      height: 160,
      child: InkWell(
        onTap: ()
        {
          print ('Tab ${product.bus_id}');
          Navigator.push(context,
              MaterialPageRoute(builder: (_) {
                return FullScreenImage(
                  imageUrl: product.photo_image,
                  tag: "generate_a_unique_tag",
                );
              }));
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            // Those are our background
            Container(
              height: 136,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: itemIndex.isEven ? kBlueColor : kSecondaryColor,
                boxShadow: const [kDefaultShadow],
              ),
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
            ),
            // our product image
            Positioned(
              top: 0,
              right: 0,
              child: Hero(
                tag: product.id,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 150,
                  // image is square but we add extra 20 + 20 padding thats why width is 200
                  width: 150,
                  child:
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 90,
                    height: 10,
                    imageUrl: product.photo_image,
                    placeholder: (context, url) => const SpinKitFadingFour(
                      color: Colors.amber,
                      size: 50.0,
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error , color: Colors.red, size: 30,),
                  ),
                ),
              ),
            ),
            // Product title and price
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                height: 136,
                // our image take 200 width, thats why we set out total width - 200
                width: size.width - 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding/2),
                      child: Text(
                        product.photo_title,
                        style: Theme.of(context).textTheme.button!.copyWith(fontFamily: 'noura'),
                      ),
                    ),
                    // it use the available space
                    const Spacer(),

                    /*
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 1.5, // 30 padding
                        vertical: kDefaultPadding / 4, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Text(
                        "\$${product.bus_id}",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),*/
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

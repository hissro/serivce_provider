import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../DataModels/UserModel.dart';
import '../MyDrawer/Drawer.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/constants.dart';
import 'UserProfileController.dart';

class UserProfile extends StatefulWidget
 {
   const UserProfile({Key? key}) : super(key: key);
 
   @override
   State<UserProfile> createState() => _UserProfileState();
 }




 class _UserProfileState extends State<UserProfile>
 {

   var controller = Get.put(UserProfileController());
   UserSession UserInfo = Get.put(UserSession()) ;
   final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key



   @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {


      // UserInfo.getUserInfo().then((myuser)
      // {
      //   User = myuser ;
      // });
    });



  }

   @override
   Widget build(BuildContext context)
   {
     final _width = MediaQuery.of(context).size.width;
     final _height = MediaQuery.of(context).size.height;


     return GetBuilder<UserSession>( // no need to initialize Controller ever again, just mention the type
       builder: (User)
       {
         return new Container(
           child: new Stack(
             children: <Widget>
             [

               new Container(
                 decoration: new BoxDecoration(
                     gradient: new LinearGradient(colors:
                     [
                       Colors.white.withOpacity(0.2),
                       Colors.white.withOpacity(0.2),
                     ],
                         begin: Alignment.topCenter, end: Alignment.center)),
               ),

               new Scaffold(
                 key: _key, // Assign
                 backgroundColor: Colors.white,
                 body: new Container(
                   child: new Stack(
                     children: <Widget>
                     [
                       Positioned(
                         top: 60,
                         right: 20,
                         child:  InkWell(
                           onTap: ()=>  _key.currentState!.openDrawer(),
                           child: Icon(
                             Icons.menu,
                           color: kPrimaryColor,),
                         )
                       ),


                       SizedBox(height: 40,),

                       new Align(
                         alignment: Alignment.center,
                         child: new Padding(
                           padding: new EdgeInsets.only(top: _height / 15),
                           child: new Column(
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: <Widget>[
                               new CircleAvatar(
                                 backgroundImage:
                                 new AssetImage('assets/images/logo.png'),
                                 radius: _height / 10,
                               ),
                               new SizedBox(
                                 height: _height / 30,
                               ),
                               new Text(
                                 '${User.user.user_fullname}',
                                 style: new TextStyle(
                                     fontSize: 18.0,
                                     color: Colors.black,
                                     fontWeight: FontWeight.bold),
                               )
                             ],
                           ),
                         ),
                       ),
                       new Padding(
                         padding: new EdgeInsets.only(top: _height / 2.2),
                         child: new Container(
                           color: Colors.white,
                         ),
                       ),


                       new Padding(
                         padding: new EdgeInsets.only(
                             top: _height / 2.6,
                             left: _width / 20,
                             right: _width / 90),
                         child: new Column(
                           children: <Widget>
                           [

                             new Padding(
                               padding: new EdgeInsets.only(top: _height / 20),
                               child: new Column(
                                 children: <Widget>[
                                   infoChild(
                                       _width, Icons.email, '${User.user.user_email}'),
                                   infoChild(_width, Icons.call, '${User.user.user_phone}' ),
                                   // infoChild(  _width, Icons.group_add, 'Add to group'),
                                   // infoChild(_width, Icons.chat_bubble, 'Show all comments'),


                                   SizedBox(height: 20,),

                                   new Padding(
                                     padding: new EdgeInsets.only(top: _height / 30),
                                     child: new Container(
                                       width: _width / 3,
                                       height: _height / 20,
                                       decoration: new BoxDecoration(
                                           color: kPrimaryColor,
                                           borderRadius: new BorderRadius.all(
                                               new Radius.circular(_height / 40)),
                                           boxShadow: [
                                             new BoxShadow(
                                                 color: Colors.black87,
                                                 blurRadius: 2.0,
                                                 offset: new Offset(0.0, 1.0))
                                           ]),
                                       child: new Center(
                                         child: new Text('تحديث البيانات',
                                             style: new TextStyle(
                                                 fontSize: 12.0,
                                                 color: Colors.white,
                                                 fontWeight: FontWeight.bold)),
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             )
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                 drawer: MyDrawer(),
               ),
             ],
           ),
         );



       }
     );


   }

   Widget headerChild(String header, int value) => new Expanded(
       child: new Column(
         children: <Widget>[
           new Text(header),
           new SizedBox(
             height: 8.0,
           ),
           new Text(
             '$value',
             style: new TextStyle(
                 fontSize: 14.0,
                 color: const Color(0xFF26CBE6),
                 fontWeight: FontWeight.bold),
           )
         ],
       ));

   Widget infoChild(double width, IconData icon, data) => new Padding(
     padding: new EdgeInsets.only(bottom: 8.0),
     child: new InkWell(
       child: new Row(
         children: <Widget>[
           new SizedBox(
             width: width / 10,
           ),
           new Icon(
             icon,
             color:   kPrimaryColor,
             // size: 36.0,
           ),
           new SizedBox(
             width: width / 20,
           ),
           new Text(data , style: TextStyle( color: Colors.grey),)
         ],
       ),
       onTap: () {
         print('Info Object selected');
       },
     ),
   );
 }
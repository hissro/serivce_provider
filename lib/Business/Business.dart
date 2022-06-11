import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:serivce/Model/BusinessModel.dart';
import 'package:serivce/MyDrawer/Drawer.dart';
import 'package:serivce/Utilities/Config.dart';
import 'package:serivce/Utilities/constants.dart';
import 'package:serivce/Utilities/network_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:serivce/Utilities/translations/Arabic.dart';

import '../BusinessDetails/BusinessDetails.dart';
import '../Utilities/Functions.dart';




class Business extends StatefulWidget
{
  static const String routeName = "Business";


  const Business({Key? key, })
      : super(key: key);
  @override
  _BusinessState createState() => _BusinessState();
}





class _BusinessState extends State<Business>
{

  var args = Get.arguments;
  var cat_id , title;




  List<BusinessModel> _business = [];

  late Future<List<BusinessModel>>  _FutureBusiness;

  final NetworkUtil _netUtil = NetworkUtil();

  final Completer<GoogleMapController> _controller = Completer();
  final List<Marker> _markers = <Marker>[];

  late BitmapDescriptor customIcon;
  final CustomInfoWindowController _customInfoWindowController =  CustomInfoWindowController();

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    cat_id  = args["cat_id"];
    title  = args["title"];
    _FutureBusiness = get_BUSINESS_LIST();
  }

  @override
  dispose()
  {
    super.dispose();
    _customInfoWindowController.dispose();
  }



  Future<List<BusinessModel>> get_BUSINESS_LIST() async
  {
    List<BusinessModel> buss = [];

    return _netUtil.post(Config.BUSINESS_LIST, body:
    {
      "cat_id": cat_id.toString(),
      // "lat": null,
      // "lon": null,
      // "rad": null,
      // "search":null
    }).then((dynamic data)
    {
      var responce = data["responce"];
      var infos = data["data"];
      if (responce) {
        for (var i in infos)
        {
          var row = BusinessModel.fromJson(i) ;
          buss.add(row);

           setState(()
           {
            _markers.add(
              Marker(
                markerId: MarkerId(row.bus_id),
                position:  LatLng( double.parse(row.bus_latitude.toString()) , double.parse(row.bus_longitude.toString()) ),
                onTap: () {
                  _customInfoWindowController.addInfoWindow!(
                    Column(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: ()
                            {

                              Get.to(BusinessDetails(),  arguments:
                              {
                                'BusinessInfo': row
                              });


                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => BusinessDetails(BusinessInfo: row),
                              //   ),
                              // );


                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color:  Colors.blueGrey ,
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        ClipOval(
                                          child: CachedNetworkImage(imageUrl: row.bus_logo,
                                            width: 50.0,
                                            height: 50.0,
                                          ),
                                        ),


                                        const SizedBox(
                                          width: 13.0,
                                        ),
                                        Column(
                                          children: [

                                            Text(
                                              row.bus_title,
                                              style: const TextStyle( fontFamily: 'noura',  color: Colors.white)
                                            ),
                                            const SizedBox(
                                              height: 3.0,
                                            ),
                                            Text(
                                                row.bus_google_street ,
                                                style: const TextStyle( fontFamily: 'noura',  color: Colors.white)
                                            ),

                                            const SizedBox(
                                              height: 7.0,
                                            ),

                                            RatingBarIndicator(
                                              rating: double.parse(row.total_rating),
                                              itemBuilder: (context, index) => const Icon(
                                                Icons.star,
                                                color: Colors.white,
                                              ),
                                              itemCount: 5,
                                              itemSize: 18.0,
                                              direction: Axis.horizontal,
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                        ),


                      ],
                    ),
                      LatLng( double.parse(row.bus_latitude.toString()) , double.parse(row.bus_longitude.toString()) ),
                  );


                },
              ),
            );



            /*
            _markers.add(
                Marker(
                    markerId: MarkerId(row.bus_id),
                    position: LatLng( double.parse(row.bus_latitude.toString()) , double.parse(row.bus_longitude.toString()) ),
                    infoWindow: InfoWindow(
                      onTap: ()
                      {




                      },
                      title: row.bus_title,
                    ),
                )
            );
            */
          });

        }
      }
      setState(()
      {
        _business = buss;
      });
      return buss;
    }, onError: (e)
    {
      print(e.toString());
      return buss;
    });
  }



  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;


    return DefaultTabController(
      length: 2,
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: kSecondaryColor,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            indicatorColor: kBlueColor,
            tabs: [
              Tab(
                icon: Icon(Icons.menu),
              ),
              Tab(
                icon: Icon(Icons.map),
              ),
            ],
          ),
          title:  Text(
            title,
            style: const TextStyle(fontFamily: 'noura'),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [



            FutureBuilder(
              future: _FutureBusiness,
              builder: (BuildContext context,
                  AsyncSnapshot<List<BusinessModel>> snapshot)
              {
                switch (snapshot.connectionState)
                {
                  case ConnectionState.waiting:
                    {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: size.height /4,),
                          const Center(child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SpinKitSpinningLines(
                              color:  Color(0xfffcc9a34),
                            ),
                          )),
                        ],
                      );
                    }
                  default:
                    {
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
                                    color:  ErrorColor ,
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
                                            'app.error'.tr,
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
                          int data = snapshot.data!.length;
                          if (data > 0)
                          {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext ctx, index)
                              {
                                var info = snapshot.data![index];

                                return InkWell(
                                   onTap:  ()
                                   {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => BusinessDetails(BusinessInfo:info )),
                                      // );
                                     Get.to(BusinessDetails(),  arguments:
                                     {
                                       'BusinessInfo': info
                                     });

                                    },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 150,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                              color: const Color(0xff7c94b6),
                                          image: DecorationImage(
                                          fit: BoxFit.cover,
                                        colorFilter:
                                        ColorFilter.mode(Colors.black.withOpacity(0.2),  BlendMode.dstATop),
                                        image: NetworkImage(
                                        info.bus_logo,
                                        ),
                                        ),
                                        ),
                                      child: Column(

                                        mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Center(
                                            child: Container(
                                              padding:const EdgeInsets.only(right: 15 , left: 15 ,top: 15   ) ,
                                              child: Expanded(
                                                child: Text(
                                                  info.bus_title,
                                                  // textAlign: TextAlign.right,
                                                  style:   TextStyle(
                                                      fontFamily: 'noura',
                                                      fontSize: 24,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),




                                          const SizedBox(height: 8,),

                                          Center(
                                            child: Container(
                                              padding:const EdgeInsets.only(right: 15 , left: 15 ,   ) ,
                                              child: Text(
                                                info.bus_google_street,
                                                // textAlign: TextAlign.right,
                                                style: const TextStyle(
                                                    fontFamily: 'noura',
                                                    fontSize: 15,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 8,),

                                          Center(
                                            child: RatingBarIndicator(
                                              rating: double.parse(info.total_rating),
                                              itemBuilder: (context, index) => const Icon(
                                                Icons.star,
                                                color: kSecondaryColor,
                                              ),
                                              itemCount: 5,
                                              itemSize: 20.0,
                                              unratedColor: Colors.black,
                                              direction: Axis.horizontal,
                                            ),
                                          ),




                                        ],
                                      ),
                                    ),
                                  ),
                                );


                                /*
                                return  InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => BusinessDetails(BusinessInfo:info )),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Container(
                                        height: 150,
                                        width: size.width,

                                        decoration: BoxDecoration(
                                          image:
                                          DecorationImage(
                                            image: NetworkImage(info.bus_logo),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(color:   kPrimaryLightColor.withOpacity(0.2), spreadRadius: 3),
                                            ],
                                          ),
                                          child: Column(
                                            children: [

                                              SizedBox(height: 49,),

                                              Container(
                                                color: Colors.transparent,
                                                child: new Container(
                                                  decoration: new BoxDecoration(
                                                      color: Colors.grey.withOpacity(0.6),
                                                      borderRadius: new BorderRadius.only(
                                                        topLeft: const Radius.circular(40.0),
                                                        topRight: const Radius.circular(40.0),
                                                        bottomLeft: const Radius.circular(40.0),
                                                        bottomRight: const Radius.circular(40.0),
                                                      )
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 38.0 , left: 38),
                                                    child: Text(
                                                      info.bus_title,
                                                      style: TextStyle(
                                                          fontFamily: 'noura',
                                                          fontSize: 24,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                );
                                */


                              },
                            );
                          }
                          else
                          {
                            return   Container(
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
                                              "لاتوجد بيانات" ,
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
                        }
                    }
                }

              },
            ),


            // Load Map Loaction And Data
            Container(
                child:
                Stack(
                  children: <Widget>
                  [
                    GoogleMap(
                      myLocationButtonEnabled : false ,
                      zoomGesturesEnabled: true,
                      tiltGesturesEnabled: false,
                      onTap: (position)
                      {
                        _customInfoWindowController.hideInfoWindow!();
                      },
                      onCameraMove: (position) {
                        _customInfoWindowController.onCameraMove!();
                      },
                      onMapCreated: (GoogleMapController controller) async {
                        _customInfoWindowController.googleMapController = controller;
                      },
                      markers: Set<Marker>.of(_markers),
                      initialCameraPosition: const CameraPosition(
                        target: LatLng(24.7239143,46.6703554),
                        // zoom: 11,  Perfect
                        zoom: 6.13,
                      ),
                    ),
                    CustomInfoWindow(
                      controller: _customInfoWindowController,
                      height: 95,
                      width: size.width - 100,
                      offset: 50,
                    ),
                  ],
                ),
            ),
          ],
        ),
        drawer: MyDrawer(),
      ),

    );
  }


}




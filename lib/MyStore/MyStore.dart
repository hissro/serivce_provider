import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:serivce/MyStore/MyStoreController.dart';
import '../BusinessDetails/widgets/top_container.dart';
import '../Model/MyOrderModel.dart';
import '../MyDrawer/Drawer.dart';
import '../OrderDetails/OrderDetails.dart';
import '../Utilities/Config.dart';
import '../Utilities/Functions.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/constants.dart';



class MyStore extends StatefulWidget
{
  const MyStore({Key? key}) : super(key: key);

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore>
{
  var Session = Get.put(UserSession()) ;
  var contr = Get.put(MyStoreController()) ;
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key



  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _key, // Assign
      body: Column(
        children: <Widget>
        [
          FutureBuilder(
            future:  contr.GetMybusInfo(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot)
            {

              if (snapshot.hasData )
              {

                var Info = snapshot.data;

                return Column(
                  children: <Widget>
                  [

                    TopContainer(
                      image: Config.BUSINESS_IMAGE +Info["bus_logo"],
                      height: 200,
                      width: width,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                // Icon(Icons.menu,  color: LightColors.kDarkBlue, size: 30.0),
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 8.0),
                                //   child: IconButton(
                                //     icon: const Icon(Icons.menu_outlined),
                                //     // onPressed: () => _key.currentState!.openDrawer(),
                                //   ),
                                // ),

                                IconButton(
                                  icon: const Icon(Icons.menu),
                                  onPressed: ()=>  _key.currentState!.openDrawer(),
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


                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Text(
                                           Info ["bus_title"],
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
                                        rating: double.parse(  Info ["total_rating"]   ),
                                        itemBuilder: (context, index) => const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),


                                    ],
                                  )
                                ],
                              ),
                            )
                          ]),
                    ),

                    /********************************************************************/

                    Container(
                      padding: EdgeInsets.only(top: 30, right: 20 , left: 20),
                      child: Row(
                        children: [
                          Text('كل الطلبات' , style: TextStyle( fontSize: 16),),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: contr.MyAppointments(Info["bus_id"]),
                      builder: (BuildContext context, AsyncSnapshot<List<MyOrderModel>> snapshot)
                      {
                        switch (snapshot.connectionState)
                        {
                          case ConnectionState.waiting:
                            {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height / 4,
                                  ),
                                  Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: SpinKitFadingCircle(
                                          itemBuilder: (BuildContext context, int index) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: index.isEven
                                                    ? const Color(0xfffcc9a34)
                                                    : const Color(0xfffcc9a64),
                                              ),
                                            );
                                          },
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
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(right: 15, left: 15),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      // Those are our background
                                      Container(
                                        height: 136,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          color: ErrorColor,
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
                                          width: size.width,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Spacer(),

                                              Center(
                                                child: Text(
                                                  'خطا في تحميل البيانات',
                                                  // snapshot.error.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button!
                                                      .copyWith(fontFamily: 'noura'),
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
                              } else
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
                                      Color status =  info.status == "0" ? Colors.teal : Colors.yellow;
                                      String Orstatus =  info.status == "0" ? "مكتمل" : "إنتظار";

                                      return InkWell(
                                        onTap: () {
                                          Get.to(OrderDetails(),  arguments:
                                          {
                                            'Info': info
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Card(
                                            clipBehavior: Clip.antiAlias,
                                            child: Column(
                                              children: [
                                                ListTile(
                                                  leading: Icon(
                                                    Icons.info_outline,
                                                    color: status,
                                                  ),
                                                  title: Text(' ${info.bus_title}'),
                                                  subtitle: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'تاريخ الطلب:  ${info.appointment_date}',
                                                        style: TextStyle(
                                                            color: Colors.black.withOpacity(0.6)),
                                                      ),
                                                      Text(
                                                        'حالة الطلب:  ${Orstatus}',
                                                        style: TextStyle(
                                                            color: status.withOpacity(0.6)),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    padding: const EdgeInsets.only(right: 15, left: 15),
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: <Widget>[
                                        // Those are our background
                                        Container(
                                          height: 136,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(22),
                                            color: kTextColor,
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
                                            width: size.width,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                const Spacer(),

                                                Center(
                                                  child: Text(
                                                    "لاتوجد طلبات",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .button!
                                                        .copyWith(fontFamily: 'noura'),
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
                    /********************************************************************/
                  ],
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
      drawer: MyDrawer(),
    );
  }
}

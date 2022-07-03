import 'package:flutter/material.dart';

import '../BusinessDetails/widgets/top_container.dart';
import '../MyDrawer/Drawer.dart';



class MyStore extends StatefulWidget
{
  const MyStore({Key? key}) : super(key: key);

  @override
  State<MyStore> createState() => _MyStoreState();
}

class _MyStoreState extends State<MyStore>
{

  @override
  Widget build(BuildContext context)
  {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>
        [

          /*
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
          */

          /********************************************************************/

          /********************************************************************/
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}

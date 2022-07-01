import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Model/MyOrderModel.dart';
import '../MyDrawer/Drawer.dart';
import '../OrderDetails/OrderDetails.dart';
import '../Utilities/Functions.dart';
import '../Utilities/constants.dart';
import 'MyOrderController.dart';

class MyOrder extends StatelessWidget {
  var controller = Get.put(MyOrderController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('طلباتي'),
      ),
      body: FutureBuilder(
        future: controller.MyAppointments(),
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
                  if (data > 0) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, index) {
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
                                      "لاتوجد بيانات",
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
      drawer: MyDrawer(),
    );
  }
}

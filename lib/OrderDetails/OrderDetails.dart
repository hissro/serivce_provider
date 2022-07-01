import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../Model/MyOrderModel.dart';
import '../Model/OrderServicesModel.dart';
import '../Utilities/Functions.dart';
import '../Utilities/constants.dart';
import 'OrderDetailsController.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({Key? key}) : super(key: key);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var PassData = Get.arguments;
  late MyOrderModel Info;
  var controller = Get.put(OrderDetailsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Info = PassData["Info"];

    print(' Info :${Info.bus_title}');
    print(' Info :${Info.id}');
    // controller.MyServices("3");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text( ' بينات الطلب ' ),
        ),
        body: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.arrow_drop_down_circle),
                  title:   Text(Info.bus_title),
                  subtitle: Text(
                    Info.app_phone,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FutureBuilder(
                    future: controller.MyServices(Info.id.toString()),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<OrderServicesModel>> snapshot) {
                      switch (snapshot.connectionState) {
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
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                            if (snapshot.hasError) {
                              return Container(
                                margin: const EdgeInsets.only(top: 10),
                                padding:
                                    const EdgeInsets.only(right: 15, left: 15),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(22),
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Spacer(),

                                            Center(
                                              child: Text(
                                                'خطا في تحميل البيانات',
                                                // snapshot.error.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .button!
                                                    .copyWith(
                                                        fontFamily: 'noura'),
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
                            } else {
                              int data = snapshot.data!.length;
                              if (data > 0)
                              {

                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (BuildContext ctx, index) {
                                    var info = snapshot.data![index];

                                    return InkWell(
                                      onTap: () {
                                        Get.to(OrderDetails(),
                                            arguments: {'Info': info});
                                      },
                                      child:  ListTile(
                                        leading: Icon(
                                          Icons.info_outline,
                                        ),
                                        title: Text(
                                            ' ${info.service_title}'),
                                        subtitle: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '  السعر:  ${info.service_price}',
                                              style: TextStyle(
                                                  color: Colors.black
                                                      .withOpacity(
                                                      0.6)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      // Those are our background
                                      Container(
                                        height: 136,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          color: kTextColor,
                                          boxShadow: const [kDefaultShadow],
                                        ),
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(22),
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Spacer(),

                                              Center(
                                                child: Text(
                                                  "لاتوجد بيانات",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .button!
                                                      .copyWith(
                                                          fontFamily: 'noura'),
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
                ),
              ],
            ),
          ),
        )

        // drawer: MyDrawer(),
        );
  }
}

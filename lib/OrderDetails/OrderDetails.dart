import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/MyOrderModel.dart';



class OrderDetails extends StatefulWidget
{
  const OrderDetails({Key? key}) : super(key: key);
  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}





class _OrderDetailsState extends State<OrderDetails>
{

  var PassData = Get.arguments;
  late MyOrderModel Info ;


  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();

    Info = PassData["Info"];

    print (' Info :${Info.bus_title}');

  }



  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(Info.bus_title),
      ),

      // drawer: MyDrawer(),
    );
  }
}

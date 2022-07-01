import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/MyOrderModel.dart';
import '../Utilities/Config.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/network_util.dart';



class MyOrderController extends GetxController
{

  final NetworkUtil _netUtil = NetworkUtil();
  var Session = Get.put(UserSession()) ;
  final session = GetStorage();


  @override
  void onInit()
  {
    super.onInit();
   }


  Future<List<MyOrderModel>> MyAppointments() async
  {

    List<MyOrderModel> Orders = [];
    var user_id =  session.read("user_id");

      return _netUtil.post(Config.MyAppointments, body:
      {
        "user_id":user_id.toString(),

      }).then((dynamic data)
      {
        var responce = data["responce"];

        var infos = data["data"];
        if (responce)
        {
          for (var i in infos)
          {
            var res = MyOrderModel.fromJson(i);
            Orders.add(res);
          }
        }
        return Orders;
      }, onError: (e)
      {
        print(e.toString());
        return Orders;
      });
  }


}
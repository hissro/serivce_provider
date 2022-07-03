import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/MyOrderModel.dart';
import '../Utilities/Config.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/network_util.dart';


class MyStoreController extends GetxController
{

  final NetworkUtil _netUtil = NetworkUtil();
  var Session = Get.put(UserSession()) ;
  final session = GetStorage();



      Future<dynamic> GetMybusInfo() async
      {
        var user_id = session.read("user_id");
         return _netUtil.post(Config.CheakVendor, body:  {  "user_id": user_id }).then((dynamic res)
          {
            return res["data"];
          }, onError: (e)
          {
            print (e);
          });
      }


      Future<List<MyOrderModel>> MyAppointments(bus_id) async
      {

        List<MyOrderModel> Orders = [];

        return _netUtil.post(Config.StoreAppointments, body:
        {
          // "bus_id": "2",
          "bus_id":bus_id.toString(),
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








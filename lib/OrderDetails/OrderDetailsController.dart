import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/OrderServicesModel.dart';
import '../Model/ServicesModel.dart';
import '../Utilities/Config.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/network_util.dart';

class OrderDetailsController extends GetxController
{




  final NetworkUtil _netUtil = NetworkUtil();
  var Session = Get.put(UserSession()) ;
  final session = GetStorage();


  @override
  void onInit()
  {
    super.onInit();
  }


  Future<List<OrderServicesModel>> MyServices(busness_appointment_id) async
  {

    List<OrderServicesModel> Services = [];


    return _netUtil.post(Config.BUSINESS_SERVICES, body:
    {
      "appointment_id":busness_appointment_id.toString(),

    }).then((dynamic data)
    {
      var responce = data["responce"];
      var infos = data["data"];

      print (' R.1 ${busness_appointment_id}');
      if (responce)
      {


        for (var i in infos)
        {
          print (i);
          var res = OrderServicesModel.fromJson(i);
          Services.add(res);
        }

      }


      return Services;
    }, onError: (e)
    {
      print(e.toString());
      return Services;
    });




  }
}
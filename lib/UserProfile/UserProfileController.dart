import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Utilities/UserSession.dart';




class UserProfileController extends GetxController
{

  var Session = Get.put(UserSession()) ;
  final session = GetStorage();


  Future<dynamic> GetUserProfile () async
  {
    Session.getUserInfo().then((Data)
    {
      return Data;
    });
  }



}
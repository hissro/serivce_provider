import 'package:get/get.dart';
import '../Model/CategoryModel.dart';
import '../Utilities/Config.dart';
import '../Utilities/network_util.dart';

class RequestProviderController extends GetxController
{

  final NetworkUtil _netUtil = NetworkUtil();
  List<Category> cats = [];
  late Category seletectd ;

  @override
  void onInit()
  {
    print (' On int Loading ');
    super.onInit();
    this.get_CATEGORY_LIST();
  }



  void updateval (Category newseletectd )
  {
    seletectd =  newseletectd;
    update(['aVeryUniqueID']);
  }


  Future<List<Category>> get_CATEGORY_LIST() async
  {

    return _netUtil.get(Config.CATEGORY_LIST).then((dynamic data)
    {
      var responce = data["responce"];
      cats = [];

      var infos = data["data"];
      if (responce)
      {
        for (var i in infos)
        {
          var res = Category.fromJson(i);
          cats.add(res);
        }
        seletectd = cats[0];
      }
      return cats;
    }, onError: (e)
    {
      print(e.toString());
      return cats;
    });
  }


}
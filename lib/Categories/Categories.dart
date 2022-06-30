import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:serivce/Model/CategoryModel.dart';
import 'package:serivce/MyDrawer/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Business/Business.dart';
import '../Utilities/Config.dart';
import '../Utilities/Functions.dart';
import '../Utilities/constants.dart';
import '../Utilities/network_util.dart';

class Categories extends StatefulWidget
{
  static const String routeName = "Categories";
  @override
  _CategoriesState createState() => _CategoriesState();
}





class _CategoriesState extends State<Categories>
{
  final NetworkUtil _netUtil = NetworkUtil();

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Future<List<Category>> get_CATEGORY_LIST() async
  {
    List<Category> cats = [];

    print (' Start Loading ');
    return _netUtil.get(Config.CATEGORY_LIST).then((dynamic data)
    {
      var responce = data["responce"];


      var infos = data["data"];
      if (responce)
      {
        for (var i in infos)
        {
          var res = Category.fromJson(i);
          cats.add(res);
        }
      }

      print (' Request Done ');


      return cats;
    }, onError: (e)
    {
      print(e.toString());
      return cats;
    });
  }

  Widget getCat()
  {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder(
      future: get_CATEGORY_LIST(),
      builder: (BuildContext context, AsyncSnapshot <List<Category>> snapshot)
      {


        switch (snapshot.connectionState)
        {
          case ConnectionState.waiting:
            {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height / 4,),
                  const Center(child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SpinKitSpinningLines(
                      color: Color(0xfffcc9a34),
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
                                    'app.error'.tr,
                                  style: Theme
                                      .of(context)
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
              else
              {
                int data = snapshot.data!.length;
                if (data > 0)
                {

                  // 428.0
                  // int count =  size.width >= 800 ? 6 : 3 ;
                  int count ;
                  if ( size.width <= 428   ) {
                    count = 3 ;
                  } else if ( size.width <= 768   ) {
                    count = 5 ;
                  } else if ( size.width <= 800 ) {
                    count = 6 ;
                  } else if ( size.width <= 1920 ) {
                    count = 8;
                  } else {
                    count = 3 ;
                  }




                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 0,
                          crossAxisCount: count),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var info = snapshot.data![index];

                        return InkWell(
                          onTap: ()
                          {

                            print (' Pressed :${info.title}');

                            Get.to(Business(),  arguments:
                            {
                              'cat_id': info.id,
                              'title': info.title
                            });


                            /*
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  Business(
                                    cat_id: info.id, title: info.title,)),
                            );
                            */

                          },
                          child: Column(
                            children: [
                              CachedNetworkImage(
                                imageUrl: info.image,
                                width: 70,
                                height: 90,
                                placeholder: (context, url) =>
                                    const Center(
                                      child: SpinKitFadingFour(
                                        color: Colors.amber,
                                        size: 50.0,
                                      ),
                                    ),
                                errorWidget: (context, url, error) =>
                                    const Icon(
                                      Icons.error,
                                      color: kPrimaryColor,
                                    ),
                              ),

                              // SizedBox(height: 10 ,),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  info.title,
                                  style: const TextStyle(fontFamily: 'noura'),
                                ),
                                decoration: BoxDecoration(
                                  // color: Colors.amber,
                                    borderRadius: BorderRadius.circular(15)),
                              ),
                            ],
                          ),
                        );
                      });
                }
                else
                {
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
                                    style: Theme
                                        .of(context)
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
    );
  }

  @override
  Widget build(BuildContext context)
  {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text('الاقسام', style: TextStyle(fontFamily: 'noura'),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: 150,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/top_bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10, right: 17, left: 17),
                        child: TextField(
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: 'كلمات البحث',
                            hintStyle:
                            const TextStyle(fontSize: 12, fontFamily: 'noura'),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        "افضل الخدمات ",
                        style: TextStyle(
                            fontFamily: 'noura',
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ) /* add child content here */,
              ),
              const SizedBox(
                height: 20,
              ),
              getCat(),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),

    );
  }

}

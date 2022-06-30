import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Login/components/text_field_container.dart';
import '../Model/CategoryModel.dart';
import '../MyDrawer/Drawer.dart';
import '../Utilities/ErrorPage.dart';
import '../Utilities/constants.dart';
import 'RequestProviderController.dart';

class RequestProvider extends StatefulWidget {
  const RequestProvider({Key? key}) : super(key: key);
  @override
  State<RequestProvider> createState() => _RequestProviderState();
}

class _RequestProviderState extends State<RequestProvider> {
  TextEditingController bus_titleController = TextEditingController();
  TextEditingController bus_slugController = TextEditingController();
  var vcontroller = Get.put(RequestProviderController());
  late Future _load ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _load = vcontroller.get_CATEGORY_LIST();
    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('الطلب كمقدم خدمة'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>
            [




              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'الرجاء تعبئة البيانات',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: bus_titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'إسم المتجر',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  // obscureText: true,
                  controller: bus_slugController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'الوصف',
                  ),
                ),
              ),

              FutureBuilder<dynamic>(
                  future: _load,
                  builder:  (BuildContext context, AsyncSnapshot<dynamic> snapshot)
                  {
                    switch (snapshot.connectionState)
                    {
                      case ConnectionState.waiting:
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: size.height / 2),
                            Center(
                              child: SpinKitFadingCircle(
                                itemBuilder: (BuildContext context, int index) {
                                  return DecoratedBox(
                                    decoration: BoxDecoration(
                                      color: index.isEven
                                          ? const Color(0xfffcc9a34)
                                          : Colors.green,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      default:
                        if (snapshot.hasError) {
                          return ErrorPage(Message: "NetworkError");
                        } else {
                          List<Category> info = snapshot.data;


                          return
                            GetBuilder<RequestProviderController>(
                              id: 'aVeryUniqueID', // here// no need to initialize Controller ever again, just mention the type
                              builder: (value) =>

                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                    width: size.width * 0.9,
                                    decoration: BoxDecoration(
                                      // color: kPrimaryLightColor,
                                      // color: kBlueColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                    child: TextFieldContainer(
                                      child: Row(
                                        children: [
                                          Text(
                                            'القسم',
                                            style: TextStyle(
                                                fontFamily: 'noura', color: kPrimaryColor),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          DropdownButton<Category>(
                                            underline: Text(''),
                                            value: vcontroller.seletectd,
                                            onChanged: (newValue)
                                            {
                                              Category x = newValue as Category;
                                              vcontroller.updateval(x);
                                            },
                                            items: snapshot.data
                                                .map<DropdownMenuItem<Category>>((value)
                                            {
                                              return DropdownMenuItem<Category>(
                                                value: value,
                                                child: Container(
                                                  width: size.width - 200,
                                                  child: new Text(value.title,
                                                      style: TextStyle(
                                                          fontFamily: 'noura',
                                                          fontSize: 16,
                                                          color: kPrimaryColor)),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                            );
                        }
                    }
                  }),


              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextField(
                  // obscureText: true,
                  controller: bus_slugController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'الوصف',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),


              InkWell(
                onTap: () {
                  print(bus_titleController.text);
                  print(bus_slugController.text);
                  print(vcontroller.seletectd.title);


                },
                child: Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:   Text('التالي'),


                ),
              ),

              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('التسجيل'),
                    onPressed: ()
                    {
                      print(bus_titleController.text);
                      print(bus_slugController.text);
                      print(vcontroller.seletectd.title);


                    },
                  )),
            ],
          )),
      drawer: MyDrawer(),
    );
  }
}

import 'package:flutter/material.dart';

import '../MyDrawer/Drawer.dart';

class RequestProvider extends StatefulWidget
{
  const RequestProvider({Key? key}) : super(key: key);
  @override
  State<RequestProvider> createState() => _RequestProviderState();
}



class _RequestProviderState extends State<RequestProvider>
{


  TextEditingController bus_titleController = TextEditingController();
  TextEditingController bus_slugController = TextEditingController();



  @override
  Widget build(BuildContext context)
  {

    return Scaffold(

      appBar: AppBar(
        title: Text('الطلب كمقدم خدمة'),
      ),


      body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>
            [

              /*
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'TutorialKart',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),

              */

              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'الرجاء تعبئة البيانات',
                    style: TextStyle(fontSize: 20),
                  ),),

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


              SizedBox(height: 10,),

              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('التسجيل'),
                    onPressed: () {
                      print(bus_titleController.text);
                      print(bus_slugController.text);
                    },
                  )
              ),

            ],
          )),

      drawer: MyDrawer(),
    );
  }
}

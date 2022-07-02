import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import '../MyDrawer/Drawer.dart';
import '../RequestProvider/RequestProvider.dart';
import '../Utilities/UserSession.dart';
import '../Utilities/translations/AppLanguage.dart';
// import 'get';


class settings extends StatefulWidget {
  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}



class _settingsState extends State<settings>
{

  UserSession UserInfo = Get.put(UserSession()) ;
  var appLang = Get.put(AppLanguage());

  var style = TextStyle(fontFamily: 'noura' , fontSize: 15) ;

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(' الإعدادات'),
      ),
      body: Container(

        child:  UserInfo.IsLogin ?
        SettingsList(
          sections: [

            SettingsSection(
              // title: Text('الإعدادات العامة'),
              tiles: <SettingsTile>
              [


                SettingsTile.navigation(
                  leading: Icon(Icons.person_add_alt),
                  title: Text('العمل كمقدم خدمة', style: style,),
                  // value: Text('العربية'),
                  onPressed: (value)
                  {
                    Get.to(()=> RequestProvider());
                  },
                ),


                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('اللغة - العربية' ,style: style,),
                  onPressed: (value)
                  {
                    print (value);
                  },
                ),



                SettingsTile.navigation(
                  leading: Icon(Icons.info_outline),
                  title: Text('عن التطبيق' ,style: style),
                  onPressed: (value)
                  {
                    print (value);
                  },
                ),


              ],
            ),
          ],
        ):
        SettingsList(
            sections: [

              SettingsSection(
                // title: Text('الإعدادات العامة'),
                tiles: <SettingsTile>
                [


                  SettingsTile.navigation(
                    leading: Icon(Icons.language),
                    title: Text('اللغة - العربية' ,style: style),
                    onPressed: (value)
                    {
                      print (value);
                    },
                  ),



                  SettingsTile.navigation(
                    leading: Icon(Icons.info_outline),
                    title: Text('عن التطبيق' ,style: style),
                    onPressed: (value)
                    {
                      print (value);
                    },
                  ),


                ],
              ),
            ],
          )
      ),
      drawer: MyDrawer(),
    );
  }




}

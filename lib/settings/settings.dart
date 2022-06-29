import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import '../MyDrawer/Drawer.dart';
import '../RequestProvider/RequestProvider.dart';
// import 'get';



class settings extends StatelessWidget
{
  const settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text(' الإعدادات'),
      ),
      body: Container(

        child:  SettingsList(
          sections: [
            SettingsSection(
              // title: Text('الإعدادات العامة'),
              tiles: <SettingsTile>
              [
                SettingsTile.navigation(
                  leading: Icon(Icons.person_add_alt),
                  title: Text('العمل كمقدم خدمة'),
                  // value: Text('العربية'),
                  onPressed: (value)
                  {
                    Get.to(()=> RequestProvider());
                  },
                ),


                SettingsTile.navigation(
                  leading: Icon(Icons.language),
                  title: Text('اللغة'),
                  value: Text('العربية'),
                  onPressed: (value)
                  {
                    print (value);
                  },
                ),


                SettingsTile.switchTile(
                  onToggle: (value) {},
                  initialValue: true,
                  leading: Icon(Icons.format_paint),
                  title: Text('Enable custom theme'),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }




}

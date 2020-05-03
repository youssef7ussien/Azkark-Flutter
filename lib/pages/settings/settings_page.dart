import '../../widgets/settings_widget/setting_font_size.dart';
import '../../widgets/settings_widget/setting_font_type.dart';
import '../../widgets/settings_widget/settings_item.dart';
import 'package:flutter/cupertino.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget 
{

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> 
{
  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        // Background(),
        Scaffold(
          backgroundColor: ruby[50],
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'الضبط',
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: <Widget>[
                _buildPublicSettings(size),
                _buildAzkarSettingsCard(size),
              ],
            ),
          ),
        ),
      ]
    );
  }

  Widget _buildAzkarSettingsCard(Size size)
  {
    return Container(
      // height: size.height*0.5,
      margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: ruby[600],
                // borderRadius: BorderRadius.circular(20),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                child: Text(
                  'إعدادات الأذكار',
                  style: new TextStyle(
                    color: ruby[50],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                // borderRadius: BorderRadius.circular(20),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)
                ),
                border: Border.all(color: ruby[600]),
            ),
            child: Column(
              children: <Widget>[
                SettingsItem(
                  activeTitle: 'تم تشغيل العداد',
                  inactiveTitle: 'تشغيل العداد',
                  nameField: 'counter',
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20)
                  ),
                ),
                SettingsItem(
                  activeTitle: 'تم وضع التشكيل',
                  inactiveTitle: 'وضع التشكيل',
                  nameField: 'diacritics',
                ),
                SettingsItem(
                  activeTitle: 'تم عرض السند',
                  inactiveTitle: 'عرض السند',
                  nameField: 'sanad',
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPublicSettings(Size size)
  {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: ruby[600],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
                child: Text(
                  'الإعدادات العامة',
                  style: new TextStyle(
                    color: ruby[50],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  topLeft: Radius.circular(20)
                ),
                border: Border.all(color: ruby[600]),
            ),
            child: Column(
              children: <Widget>[
                SettingFontType(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20)
                  ),
                ),
                SettingFontSize(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
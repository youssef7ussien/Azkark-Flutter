import 'package:azkark/providers/prayer_provider.dart';
import 'package:azkark/widgets/prayer_widget/prayer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utilities/colors.dart';
import '../../widgets/prayer_widget/tab_bar.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/slider_font_size/button_font_size.dart';
import '../../widgets/slider_font_size/slider_font_size.dart';
import '../../pages/prayer/view_surah_prayer.dart';
import 'package:provider/provider.dart';
import '../../utilities/background.dart';
import 'package:flutter/material.dart';
import 'view_aya_prayer.dart';

class ViewPrayer extends StatefulWidget 
{

  @override
  _ViewPrayerState createState() => _ViewPrayerState();
}

enum PopUpMenu {ShowAllAyat}

class _ViewPrayerState extends State<ViewPrayer> with SingleTickerProviderStateMixin
{
  bool _showSliderFont,_showAllAyat;
  List<bool> _showAlAyat;
  double _fontSize;

  @override
  void initState() {
    super.initState();
    _showSliderFont=false;
    _showAllAyat=false;
    _fontSize=Provider.of<SettingsProvider>(context,listen: false).getsettingField('font_size');
    _showAlAyat=List<bool>();
    for(int i=0; i<Provider.of<PrayerProvider>(context,listen: false).allSurah.length ; i++)
      _showAlAyat.add(false);
  }

  @override
  void dispose() 
  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final prayerProvider=Provider.of<PrayerProvider>(context,listen: false);
    
    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'دعاء من القرآن',
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              ButtonFontSize(
                showSider: _showSliderFont,
                onTap: (){
                  setState(() {
                    _showSliderFont ? _showSliderFont=false : _showSliderFont=true;
                  });
                },
              ),
              _buildPopUpMenu(),
            ],
          ),
          body: Stack(
            children: <Widget>[
              SizedBox(
                  width: size.width,
                  height: size.height,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: prayerProvider.allSurah.length,
                    itemBuilder:  (context, index){
                      return Padding(
                        padding: index==0 ? 
                          const EdgeInsets.only(top:8.0,bottom: 4.0,left: 8.0,right: 8.0)
                          : index==prayerProvider.allSurah.length-1 ?
                          const EdgeInsets.only(top: 4.0,bottom: 8.0,left: 8.0,right: 8.0)
                          : const EdgeInsets.only(top: 4.0,bottom: 4.0,left: 8.0,right: 8.0),
                        child: Prayer(
                          fontSize: _fontSize,
                          surahNumber: index,
                          showAlAyat: _showAlAyat[index],
                          onTap: (){
                            setState(() {
                              _showAlAyat[index]=!_showAlAyat[index];
                            });
                          },
                        ),
                      );
                    }
                  ),
              ),
              if(_showSliderFont)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SliderFontSize(
                      fontSize: _fontSize,
                      min: 14,
                      max: 30,
                      onChanged: (value){
                        setState(() {
                          _fontSize=value;
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]
    );
  }

  Widget _buildPopUpMenu()
  {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: PopupMenuButton<PopUpMenu>(
        offset: Offset(0,50),
        tooltip: 'قائمة الخيارات',
        onSelected:(PopUpMenu result) async {
          switch(result)
          {
            
            
            case PopUpMenu.ShowAllAyat:
            {
              setState(() {
                _showAllAyat=!_showAllAyat;
                for(int i=0; i<Provider.of<PrayerProvider>(context,listen: false).allSurah.length ; i++)
                _showAllAyat ? _showAlAyat[i]=true : _showAlAyat[i]=false;
              });
            } break;
          }
        },
        itemBuilder: (context){
          return [
            PopupMenuItem<PopUpMenu>(
              value: PopUpMenu.ShowAllAyat,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FaIcon(
                    _showAllAyat ? FontAwesomeIcons.toggleOn : FontAwesomeIcons.toggleOff,
                    color: _showAllAyat ? ruby[500] : ruby,
                    size: 20,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _showAllAyat ? 'تم عرض معاني كل الأسماء' : 'عرض معاني كل الأسماء',
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        color: ruby[900],
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                      ),  
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
      ),
    );
  }

}
import 'package:azkark/pages/search/search_asmaallah.dart';
import 'package:azkark/providers/settings_provider.dart';

import '../../widgets/slider_font_size/button_font_size.dart';
import '../../widgets/slider_font_size/slider_font_size.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../widgets/asmaallah_widget/asmaallah.dart';
import '../../providers/asmaallah_provider.dart';
import '../../utilities/colors.dart';
import 'package:provider/provider.dart';
import '../../utilities/background.dart';
import 'package:flutter/material.dart';

class ViewAsmaAllah extends StatefulWidget 
{

  @override
  _ViewAsmaAllahState createState() => _ViewAsmaAllahState();
}

enum PopUpMenu {ShowAllDescription , About}

class _ViewAsmaAllahState extends State<ViewAsmaAllah> 
{
  double fontSize;
  bool showSliderFont,showAllDescription;
  List<bool> showDescription;
  @override
  void initState()
  {
    super.initState();
    showSliderFont=false;
    showAllDescription=false;
    fontSize=Provider.of<SettingsProvider>(context,listen: false).getsettingField('font_size');
    showDescription=List<bool>();
    for(int i=0 ; i<Provider.of<AsmaAllahProvider>(context,listen: false).length ; i++)
      showDescription.add(false);
  }
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final asmaAllahProvider=Provider.of<AsmaAllahProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'أسماء الله الحسني',
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            actions: <Widget>[
              ButtonFontSize(
                showSider: showSliderFont,
                onTap: (){
                  setState(() {
                    showSliderFont ? showSliderFont=false : showSliderFont=true;
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
                child: Column(
                  children: <Widget>[
                    _buildSearchBar(size),
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: asmaAllahProvider.length,
                        itemBuilder:  (context, index){
                          return Padding(
                            padding: index==0 ? 
                              const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0)
                              : index==asmaAllahProvider.length-1 ?
                              const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0)
                              : const EdgeInsets.only(left: 5.0,right: 5.0),
                            child: AsmaAllah(
                              asmaallah: asmaAllahProvider.getAsmaAllah(index),
                              fontSize: fontSize,
                              showDescription: showDescription[index],
                              onTap: (){
                                setState(() {
                                  showDescription[index]=!showDescription[index];
                                });
                              },
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
              if(showSliderFont)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SliderFontSize(
                      fontSize: fontSize,
                      min: 14,
                      max: 30,
                      onChanged: (value){
                        setState(() {
                          fontSize=value;
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

  Widget _buildSearchBar(Size size)
  {
    return InkWell(
      onTap: ()  {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child : SearchPage(),
            );
          }),
        );
      },
      child: Container(
          width: size.width,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ruby,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          height: size.height*0.055,
          decoration: BoxDecoration(
            color: ruby[700],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: ruby[50],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'إبحث عن إسم من أسماء الله . . . ',
                  style: TextStyle(
                    color: ruby[300],
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
            
            case PopUpMenu.ShowAllDescription:
            {
              setState(() {
                for(int i=0 ; i<Provider.of<AsmaAllahProvider>(context,listen: false).length ; i++)
                  showAllDescription ? showDescription[i]=false : showDescription[i]=true;
                showAllDescription=!showAllDescription;
              });
            } break;
            case PopUpMenu.About:
            {

            } break;
          }
        },
        itemBuilder: (context){
          return [
            PopupMenuItem<PopUpMenu>(
              value: PopUpMenu.ShowAllDescription,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FaIcon(
                    showAllDescription ? FontAwesomeIcons.toggleOn : FontAwesomeIcons.toggleOff,
                    color:showAllDescription ? ruby[500] : ruby,
                    size: 20,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      showAllDescription ? 'تم عرض معاني كل الأسماء' : 'عرض معاني كل الأسماء',
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
            PopupMenuItem<PopUpMenu>(
              value: PopUpMenu.About,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.help_outline,
                    color: ruby,
                    size: 25,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      'حول',
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
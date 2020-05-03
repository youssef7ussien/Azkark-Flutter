import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class ButtonFontSize extends StatefulWidget 
{
  final bool showSider;
  final Function onTap;
  
  ButtonFontSize({
    this.showSider,
    this.onTap,
  });

  @override
  _ButtonFontSizeState createState() => _ButtonFontSizeState();
}

class _ButtonFontSizeState extends State<ButtonFontSize> 
{
  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'تغيير حجم الخط',
      padding: EdgeInsets.all(0.0),
      highlightColor: Colors.transparent,
      splashColor: ruby[700],
      icon: Container(
        padding: EdgeInsets.only(top: 2.5,bottom: 2.5,left: 5.0,right: 5.0),
        decoration: BoxDecoration(
          color: widget.showSider ? ruby[50] : Colors.transparent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: FaIcon(
          FontAwesomeIcons.font,
          color: widget.showSider ? ruby[800] : ruby[50],
          size: 20,
        ),
      ),
      onPressed: widget.onTap,
    );
  }
}
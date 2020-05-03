import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class SliderFontSize extends StatefulWidget 
{
  final double fontSize,min,max,divisions;
  final Function onChanged,onChangedEnd;
  final Color overlayColor;
  
  SliderFontSize({
  this.fontSize,
  this.min,
  this.max,
  this.divisions,
  this.overlayColor,
  this.onChanged,
  this.onChangedEnd,
  });
  @override
  _SliderFontSizeState createState() => _SliderFontSizeState();
}

class _SliderFontSizeState extends State<SliderFontSize> 
{
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.only(right: 5.0,left: 8.0),
      width: size.width*0.8,
      height: size.height*0.1,
      decoration: BoxDecoration(
        color: widget.overlayColor==null ?  ruby[100].withAlpha(175) : widget.overlayColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            width: size.width*0.7,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: ruby[600],
                inactiveTrackColor: ruby[300],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: ruby[500],
                overlayColor: ruby[900].withAlpha(15),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 14.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: ruby[600],
                inactiveTickMarkColor: ruby[300],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: ruby[500],
                valueIndicatorTextStyle: TextStyle(
                  color: ruby[100],
                  fontSize: widget.fontSize,
                ),
              ),
              child: Slider(
                min: 14,
                max: 30,
                divisions: 8,
                label: '${widget.fontSize}',
                value: widget.fontSize,
                onChanged: widget.onChanged,
                onChangeEnd: widget.onChangedEnd,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:math';

import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class Surah extends StatefulWidget 
{
  final int number;
  final double fontSize;
  final String surah;
  final bool showAlAyat;
  final Function onTap;

  const Surah({
    this.number,
    this.fontSize,
    this.surah,
    this.onTap,
    this.showAlAyat,
  });
  @override
  _SurahState createState() => _SurahState();
}

class _SurahState extends State<Surah>
{

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return Material(
      color: ruby[300],
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: ruby[200],
        borderRadius: BorderRadius.circular(10),
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            // color: ruby[300],
            borderRadius: BorderRadius.circular(10)
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: _buildNumberField(size)
              ),
              Padding(
                 padding: const EdgeInsets.only(top: 10.0,bottom:  10.0,left: 15.0,right: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _buildNameField(),
                    Icon(
                      widget.showAlAyat ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: ruby[700],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField(Size size)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
      decoration: BoxDecoration(
        color: ruby[200],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10)
        )
      ),
      child: Text(
        '${widget.number}',
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: ruby[700],
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildNameField()
  {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Text(
        'سورة ${widget.surah}',
        textAlign: TextAlign.center,
        style: new TextStyle(
          color: ruby,
          fontWeight: FontWeight.w700,
          fontSize: widget.fontSize,
        ),
      ),
    );
  }

}
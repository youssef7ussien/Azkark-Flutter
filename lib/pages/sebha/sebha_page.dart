import 'dart:math';

import 'package:azkark/models/sebha_model.dart';
import 'package:azkark/utilities/background.dart';
import 'package:flutter/services.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class SebhaPage extends StatefulWidget
{
  final SebhaModel _tasbih;

  SebhaPage(this._tasbih);

  @override
  _SebhaPageState createState() => _SebhaPageState();
}

class _SebhaPageState extends State<SebhaPage> 
{
  int counter,i,currentCounter,round;
  double percentage;
  @override
  void initState() {
    super.initState();
    counter=0;
    i=1;
    currentCounter=0;
    round=0;
    percentage=0.0;
  }
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    // final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'المسبحة',
              style: new TextStyle(
                color: ruby10,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: Container(
            // height: size.height*0.5,
            // width: size.width,
            child: Column(
              children: <Widget>[
                _buildName(size),
                _buildNumberCount(size),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildRoundNumber(size),
                    _buildCurrentNumber(size),
                  ],
                ),
                _buildCounter(size),
                Expanded(
                  child: _buildButton(size)
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildName(Size size)
  {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        width: size.width*0.9,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: ruby30,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget._tasbih.nameWithDiacritics,
          textAlign: TextAlign.center,
          style: new TextStyle(
            color: ruby,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  
  Widget _buildNumberCount(Size size)
  {
    return Center(
      child: Container(
        // width: size.width*0.9,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 20.0,right: 20.0),
        decoration: BoxDecoration(
          color: ruby20,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'عدد الحبات : ${widget._tasbih.counter}',
          style: new TextStyle(
            color: ruby,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildRoundNumber(Size size)
  {
    return Center(
      child: Container(
        // width: size.width*0.9,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 20.0,right: 20.0),
        decoration: BoxDecoration(
          color: ruby20,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'دورة : $round',
          style: new TextStyle(
            color: ruby,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
  
  Widget _buildCurrentNumber(Size size)
  {
    return Center(
      child: Container(
        // width: size.width*0.9,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 20.0,right: 20.0),
        decoration: BoxDecoration(
          color: ruby20,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'العدد الحالي : $currentCounter',
          style: new TextStyle(
            color: ruby,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(Size size)
  {
    return Center(
      child: Container(
        // width: size.width*0.9,
        margin: EdgeInsets.only(top: 10,bottom: 10),
        child: Text(
          counter.toString(),
          style: new TextStyle(
            color: ruby,
            fontWeight: FontWeight.w500,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
  
  Widget _buildButton(Size size)
  {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: ruby,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: InkWell(
          splashColor: ruby80,
          highlightColor: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          onTap: (){
            print('You cliked on photo ${i++}');
            // HapticFeedback.vibrate();
            setState(() 
            {
              percentage=((currentCounter*100)/widget._tasbih.counter)*0.01;
              counter++;
              if(currentCounter<widget._tasbih.counter)
                currentCounter++;
                else
                {
                  currentCounter=1;
                  round++;
                  percentage=0.0;
                }
            });
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
            color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage('assets/images/background/sebha_back.png'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0x15F9F0F3),
                  BlendMode.modulate
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class ProgressLine extends CustomPainter
{
  double _completePercent;
  ProgressLine(this._completePercent);

  @override
  void paint(Canvas canvas, Size size) 
  {
    Paint complete=new Paint()
      ..color=yellow
      ..strokeCap=StrokeCap.round
      ..style=PaintingStyle.stroke
      ..strokeWidth=10;

    // canvas.drawLine(Offset(0,0),Offset(size.width*_completePercent,0) , complete);

    canvas.drawRect(Rect.fromLTRB(0, size.height, size.width*_completePercent, 0), complete);
    
    // canvas.drawRect(
    //   Rect.fromLTWH(0.0, 0.0, size.width * (_completePercent), 50),
    //   complete
    // );
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
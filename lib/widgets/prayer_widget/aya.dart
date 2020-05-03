import 'package:flutter/services.dart';

import '../../providers/favorites_provider.dart';
import '../../providers/prayer_provider.dart';
import '../../models/prayer_model.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Aya extends StatefulWidget 
{
  final PrayerModel prayer;
  final double fontSize;
  
  Aya({
    this.prayer,
    this.fontSize,
  });

  @override
  _AyaState createState() => _AyaState();
}

class _AyaState extends State<Aya> 
{

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;

    return Card(
      color: ruby[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: size.width,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: ruby[100],
          borderRadius: BorderRadius.circular(10),
          onLongPress: (){
            copyText();
          },
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _buildFavoriteButton()
              ),
              Align(
                alignment: Alignment.center,
                child: _buildBesmellahField(size)
              ),
              _buildAyaField(),
              _buildBottomWidget(size),
            ],
          ),
        ),
      ),
    );
  }

  void copyText()
  {
    String tempText = 
      widget.prayer.aya;
    tempText+='\n***********\nسورة :\n'+widget.prayer.surah+'\n***********\nالأية :\n ${widget.prayer.ayaNumber}';
    
    Clipboard.setData(ClipboardData(text: tempText));

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
          'تم النسخ إلي الحافظة',
          style: new TextStyle(
          color: ruby[100],
          fontFamily: '0',
          fontSize: 14,
        ),
      ),
      backgroundColor: ruby,
      duration: Duration(milliseconds: 500),
    ));
  }

  Widget _buildBesmellahField(Size size)
  {
    return Image.asset(
      'assets/images/al_basmalla.png',
      fit: BoxFit.contain,
      height: size.width*0.065,
    );
  }
  
  Widget _buildAyaField()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0,bottom: 15.0,right: 10.0,left: 10.0),
      child: Text(
        widget.prayer.aya,
        style: new TextStyle(
          color: ruby,
          fontFamily: '3',
          // fontWeight: FontWeight.w700,
          fontSize: widget.fontSize+2,
        ),
      ),
    );
  }

  Widget _buildFavoriteButton()
  {
    final parayerProvider=Provider.of<PrayerProvider>(context,listen: false);
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: ruby[400],
        splashColor: ruby[400],
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          print('You clicked on Favorite');
          setState(() {
            widget.prayer.favorite==1 ? widget.prayer.setFavorite(0) : widget.prayer.setFavorite(1);
          });
          await parayerProvider.updateFavorite(widget.prayer.favorite,widget.prayer.id);
          if(widget.prayer.favorite==1)
            await Provider.of<FavoritesProvider>(context,listen: false).addFavorite(1,widget.prayer.id);
          else if(widget.prayer.favorite==0)
            await Provider.of<FavoritesProvider>(context,listen: false).deleteFavorite(1,widget.prayer.id);
        },
        child: Container(
          height: 35,
          width: 35,
          padding:  EdgeInsets.all(5.0),
          child: Image.asset(
            widget.prayer.favorite==1 ? 
            'assets/images/icons/favorites/favorite_128px.png'
            : 'assets/images/icons/favorites/nonfavorite_128px.png' ,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomWidget(Size size)
  {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0,vertical: 5.0),
      decoration: BoxDecoration(
        color: ruby[600],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildNameSurahField(size),
          _buildAyaNumberField(size),
        ],
      ),
    );
  }

  Widget _buildNameSurahField(Size szie)
  {
    return Text(
      'سورة ${widget.prayer.surah}',
      style: new TextStyle(
        color: ruby[50],
        fontSize: 13,
      ),
    );
  }
  
  Widget _buildAyaNumberField(Size szie)
  {
    return Text(
      'الآية ${widget.prayer.ayaNumber}',
      style: new TextStyle(
        color: ruby[50],
        fontSize: 13,
      ),
    );
  }

}


// class CardPainter extends CustomPainter 
// {

//   @override
//   void paint(Canvas canvas, Size size) 
//   {
//     Paint paint=Paint();
//     paint.color=ruby[500];
//     paint.style=PaintingStyle.fill;

//     Path path=Path();

//     path.moveTo(0, size.height*0.2);
//     path.quadraticBezierTo(size.width*0.2, size.height*0.05, size.width*0.5,size.height*0.25);
//     path.quadraticBezierTo(size.width*0.75, size.height*0.42,size.width, size.height*0.25);
//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);
//     path.close();
//     canvas.drawPath(path, paint);
    
//     path=Path();
//     path.moveTo(size.width*0.43, size.height*0.18);
//     // path.quadraticBezierTo(size.width*0.2, size.height*0.03, size.width*0.5,size.height*0.25);
//     path.quadraticBezierTo(size.width*0.73, size.height*0.42,size.width, size.height*0.23);
//     path.lineTo(size.width, size.height*0.18);
//     path.lineTo(size.width*0.5, size.height*0.18);
//     path.close();
//     paint.color=ruby[400];
//     canvas.drawPath(path, paint);

//     path=Path();
//     path.moveTo(0,size.height*0.22);
//     path.quadraticBezierTo(size.width*0.2, size.height*0.07,size.width*0.5, size.height*0.27);
//     path.quadraticBezierTo(size.width*0.75, size.height*0.44,size.width, size.height*0.27);
//     path.lineTo(size.width,size.height);
//     path.lineTo(0,size.height);
//     path.close();
//     paint.color=ruby[500];
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CardPainter oldDelegate) => false;
// }
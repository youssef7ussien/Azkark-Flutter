import 'dart:math';
import '../../providers/categories_provider.dart';
import '../../utilities/colors.dart';
import '../../utilities/background.dart';
import '../../providers/azkar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewAzkar extends StatefulWidget 
{

  @override
  _ViewAzkarState createState() => _ViewAzkarState();
}

class _ViewAzkarState extends State<ViewAzkar> 
{
  int onFavorite,numberZekr,counter;
  double percentage;
  @override
  void initState() 
  {
    super.initState();
    int id=Provider.of<AzkarProvider>(context,listen: false).getZekr(0).categoryId;
    onFavorite=Provider.of<CategoriesProvider>(context,listen: false).getCategory(id).favorite;
    numberZekr=1;
    percentage=0.0;
    counter=0;
  }

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final azkarProvider=Provider.of<AzkarProvider>(context,listen: false);
    final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              categoriesProvider.getCategory(azkarProvider.getZekr(0).categoryId).nameWithDiacritics,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: ruby10,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: PageView.builder(
                    itemCount: azkarProvider.length,
                    itemBuilder:(context, int index) {
                      return _buildPageOfZekr(categoriesProvider,azkarProvider,size,index);
                    },
                    onPageChanged: (value)
                    {
                      setState(() {
                        numberZekr=value+1;
                        counter=0;
                        percentage=0.0;
                      });
                    },
                  ),
                ),
              ),
              _buildTopWidgetMain(categoriesProvider,azkarProvider,size),
              Align(
                alignment: Alignment.bottomCenter,
                child: _buildBottomWidgetMain(azkarProvider,size)
              ),
            ],
          )
        ),
      ]
    );
  }

  Widget _buildTopWidgetMain(CategoriesProvider categoriesProvider,AzkarProvider azkarProvider,Size size)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildNumberOfAzkar(azkarProvider,numberZekr),
          _buildFavoriteButton(categoriesProvider,azkarProvider.getZekr(0).categoryId),
        ],
      ),
    );
  }

  Widget _buildBottomWidgetMain(AzkarProvider azkarProvider,Size size)
  {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: size.width,
      height: 100,
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: (){
          setState(() {
            counter++;
            percentage=((counter*100)/azkarProvider.getZekr(numberZekr-1).counterNumber)*0.01;
          });
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: _buildNumberRepetitions(azkarProvider,size),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: _buildCounterButton(azkarProvider,size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageOfZekr(CategoriesProvider categoriesProvider,AzkarProvider azkarProvider,Size size,int index)
  {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: size.height*0.1,
          bottom: 80,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildTextZekr(azkarProvider,index,size),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildTextSanad(azkarProvider,index,size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteButton(CategoriesProvider categoriesProvider,int id)
  {
    return Material(
      color: ruby20,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: ruby40,
        splashColor: ruby40,
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          print('You clicked on Favorite');
          setState(() {
            onFavorite==1 ? onFavorite=0 : onFavorite=1;
          });
          await categoriesProvider.updateFavorite(onFavorite,id);
        },
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color:ruby50),
          borderRadius: BorderRadius.circular(10),
        ),
          padding:  EdgeInsets.all(5.0),
          child: Image.asset(
            onFavorite==1 ? 
            'assets/images/icons/favorites/favorite_128px.png'
            : 'assets/images/icons/favorites/nonfavorite_128px.png' ,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildNumberOfAzkar(AzkarProvider azkarProvider,int number)
  {
    return Container(
      padding: EdgeInsets.only(top: 8.0,bottom: 8.0,left: 15.0,right: 15.0),
      decoration: BoxDecoration(
        color: ruby20,
        border: Border.all(color:ruby50),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'الذكر $number من ${azkarProvider.length}',
        style: new TextStyle(
          color: rubyDark,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTextZekr(AzkarProvider azkarProvider,int index,Size size)
  {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: (){
        setState(() {
          counter++;
          percentage=((counter*100)/azkarProvider.getZekr(numberZekr-1).counterNumber)*0.01;
        });
      },
      child: Container(
        width: size.width,
        padding: EdgeInsets.all(20.0),
        constraints: BoxConstraints(
            minHeight: size.height*0.4,
            maxHeight: double.infinity,
        ),
        decoration: BoxDecoration(
          color: ruby30,
          // border: Border.all(color:ruby),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          azkarProvider.getZekr(index).textWithDiacritics,
          style: new TextStyle(
            color: rubyDark,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildTextSanad(AzkarProvider azkarProvider,int index,Size size)
  {
    return Container(
      width: size.width,
      padding: EdgeInsets.only(left: 15.0,right: 15.0),
      decoration: BoxDecoration(
        color: ruby20,
        border: Border.all(color:ruby30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        title: Text(
          'معلومات',
          style: new TextStyle(
            color: gray80,
            fontSize: 12,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              azkarProvider.getZekr(index).sanad,
              style: new TextStyle(
                color: gray80,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCounterButton(AzkarProvider azkarProvider,Size size)
  {
    double radius=30;
    return CustomPaint(
      painter: CircleCounter(percentage,radius),
      child: Container(
        height: radius*2,
        width: radius*2,
        child: Center(
          child: Text(
            counter.toString(),
            style: new TextStyle(
              color: ruby10,
              fontSize: 20, //percentage=((currentCounter*100)/widget._tasbih.counter)*0.01;
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberRepetitions(AzkarProvider azkarProvider,Size size)
  {
    return Container(
      width: size.width*0.9,
      padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 15.0,right: 15.0),
      decoration: BoxDecoration(
        color: ruby80,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        azkarProvider.getZekr(numberZekr-1).counterText==null ?
        'مرة واحدة' : azkarProvider.getZekr(numberZekr-1).counterText,
        style: new TextStyle(
          color: ruby10,
          fontSize: 14,
        ),
      ),
    );
  }

}

class CircleCounter extends CustomPainter 
{
  double _percentage,_radius;
  CircleCounter(this._percentage,this._radius);

  @override
  void paint(Canvas canvas, Size size) 
  {
    Paint circle=new Paint()
    ..color=ruby
    ..strokeCap=StrokeCap.round
    ..style=PaintingStyle.fill
    ..strokeWidth=20;

    Paint complete=new Paint()
      ..color=yellow
      ..strokeCap=StrokeCap.round
      ..style=PaintingStyle.stroke
      ..strokeWidth=8;

    canvas.drawCircle(Offset(_radius,size.height-_radius), _radius, circle);

    double arcAngle=2*pi*(_percentage);
    canvas.drawArc(
        new Rect.fromCircle(center: Offset(_radius,size.height-_radius),radius: _radius),
        -pi,
        arcAngle,
        false,
        complete
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) 
  {
    return true;
  }

}
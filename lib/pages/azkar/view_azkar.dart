import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

enum PopUpMenu {Favorite ,TurnOnCounter ,TurnOnDiacritics ,RefreshAll , About}
enum PopUpFontSize {Increase , Decrease}

class _ViewAzkarState extends State<ViewAzkar> 
{
  int onFavorite;
  bool _showSliderFont,_isCounterOpen,_isDiacriticsOpen;
  List<bool> isFinish,showSanad;
  double percentage,fontSize;
  List<int> counter;

  @override
  void initState() 
  {
    super.initState();
    int id=Provider.of<AzkarProvider>(context,listen: false).getZekr(0).categoryId;
    onFavorite=Provider.of<CategoriesProvider>(context,listen: false).getCategory(id).favorite;
    percentage=0.0;
    _showSliderFont=false;
    _isCounterOpen=true;
    _isDiacriticsOpen=true;
    fontSize=14;
    counter=List<int>();
    isFinish=List<bool>();
    showSanad=List<bool>();
    for(int i=0 ; i<Provider.of<AzkarProvider>(context,listen: false).length ; i++)
    {
      counter.add(0);
      isFinish.add(false);
      showSanad.add(false);
    }
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
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              categoriesProvider.getCategory(azkarProvider.getZekr(0).categoryId).nameWithDiacritics,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              _buildButtonFontSize(),
              _buildPopUpMenu(categoriesProvider,azkarProvider),
            ],
          ),
          body: Stack(

            children: <Widget>[
              SizedBox(
                width: size.width,
                height: size.height,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: azkarProvider.length,
                  itemBuilder:(context, int index) {
                    return Padding(
                      padding: 
                        index==0 ? 
                          const EdgeInsets.only(top: 12.0,bottom: 6.0,left: 12.0,right: 12.0)
                        : index==azkarProvider.length-1 ?
                          const EdgeInsets.only(top: 6.0,bottom: 12.0,left: 12.0,right: 12.0)
                        : const EdgeInsets.only(top: 6.0,bottom: 6.0,left: 12.0,right: 12.0),
                      child: _buildZekrCard(azkarProvider,index,size),
                    );
                  },
                ),
              ),
              if(_showSliderFont)
                Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: _buildSliderFontSize(size)
                  ),
                ),
            ],
          )
        ),
      ]
    );
  }

  Widget _buildPopUpMenu(CategoriesProvider categoriesProvider,AzkarProvider azkarProvider)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: PopupMenuButton<PopUpMenu>(
        offset: Offset(0,50),
        onSelected:(PopUpMenu result) async {
          switch(result)
          {
            case PopUpMenu.Favorite:
            {
              print('You clicked on Favorite');
              setState(() {
                onFavorite==1 ? onFavorite=0 : onFavorite=1;
              });
              await categoriesProvider.updateFavorite(onFavorite,azkarProvider.getZekr(0).id);
            } break;

            case PopUpMenu.TurnOnCounter:
            {
              setState(() {
              _isCounterOpen ? _isCounterOpen=false : _isCounterOpen=true;
            });
            } break;

            case PopUpMenu.TurnOnDiacritics:
            {
              setState(() {
              _isDiacriticsOpen ? _isDiacriticsOpen=false : _isDiacriticsOpen=true;
            });
            } break;
            
            case PopUpMenu.RefreshAll:
            {
              setState(() {
                for(int i=0 ; i<azkarProvider.length ; i++)
                {
                  counter[i]=0;
                  isFinish[i]=false;
                }
              });
            } break;

            case PopUpMenu.About:
              break;
          }
        },
        itemBuilder: (context){
          return [
            PopupMenuItem<PopUpMenu>(
              value: PopUpMenu.Favorite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: ruby[100],
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(3.0),
                    child: Image.asset(
                      onFavorite==1 ? 
                      'assets/images/icons/favorites/favorite_128px.png'
                      : 'assets/images/icons/favorites/nonfavorite_128px.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      onFavorite==1 ? 'تم الإضافة إلي المفضلة' : 'الإضافة إلي المفضلة',
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
              value: PopUpMenu.TurnOnCounter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FaIcon(
                    _isCounterOpen ? FontAwesomeIcons.toggleOn : FontAwesomeIcons.toggleOff,
                    color:_isCounterOpen ? ruby[500] : ruby,
                    size: 20,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _isCounterOpen ? 'تم تشغيل العداد' : 'تشغيل العداد',
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
              value: PopUpMenu.TurnOnDiacritics,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FaIcon(
                    _isDiacriticsOpen ? FontAwesomeIcons.toggleOn : FontAwesomeIcons.toggleOff,
                    color:_isDiacriticsOpen ? ruby[500] : ruby,
                    size: 20,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      _isDiacriticsOpen ? 'تم وضع التشكيل' : 'وضع التشكيل',
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
              value: PopUpMenu.RefreshAll,
              enabled: _isCounterOpen ? true : false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Icons.refresh,
                    textDirection: TextDirection.rtl,
                    color: ruby,
                    size: 25,
                  ),
                  Container(
                    width: 150,
                    alignment: Alignment.centerRight,
                    child: Text(
                      'تصفير العداد',
                      textAlign: TextAlign.right,
                      style: new TextStyle(
                        color: _isCounterOpen ? ruby[900] : ruby[900].withAlpha(125),
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

  Widget _buildButtonFontSize()
  {
    return IconButton(
      padding: EdgeInsets.all(0.0),
      highlightColor: Colors.transparent,
      splashColor: ruby[700],
      icon: Container(
        padding: EdgeInsets.only(top: 2.5,bottom: 2.5,left: 5.0,right: 5.0),
        decoration: BoxDecoration(
          color: _showSliderFont ? ruby[100] : Colors.transparent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: FaIcon(
          FontAwesomeIcons.font,
          color: _showSliderFont ? ruby[800] : ruby[100],
          size: 20,
        ),
      ),
      onPressed: (){
        setState(() {
          _showSliderFont ? _showSliderFont=false : _showSliderFont=true;
        });
      }
    );
  }

  Widget _buildSliderFontSize(Size size)
  {
    return Container(
      padding: const EdgeInsets.only(right: 5.0,left: 8.0),
      width: size.width*0.8,
      height: size.height*0.1,
      decoration: BoxDecoration(
        color: ruby[100].withAlpha(175),
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
                  fontSize: fontSize,
                ),
              ),
              child: Slider(
                min: 14,
                max: 30,
                divisions: 8,
                label: '$fontSize',
                value: fontSize,
                onChanged: (value) {
                  setState(() {
                    fontSize=value;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildZekrCard(AzkarProvider azkarProvider,int index,Size size)
  {
    return Material(
      color: isFinish[index] ? ruby[200] : ruby[300],
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: ruby[200],
        borderRadius: BorderRadius.circular(10),
        onTap: _isCounterOpen ?  (){
          setState(() {
          if(counter[index]<azkarProvider.getZekr(index).counterNumber)
          {
            counter[index]++;
            if(counter[index]==azkarProvider.getZekr(index).counterNumber) 
              isFinish[index]=true;
          }
          // percentage=((counter*100)/azkarProvider.getZekr(index).counterNumber)*0.01;
          });
        } : null,
        child: Container(
          width: size.width,
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            // color: isFinish[index] ? ruby[200] : ruby[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: <Widget>[
              _buildRefreshButton(azkarProvider,index,size),
              _buildTextZekr(azkarProvider,index,size),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: _buildNumberRepetitions(azkarProvider,index,size),
              ),
              _buildBottomWidget(azkarProvider,index,size),
              if(showSanad[index])
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: _buildTextSanad(azkarProvider,index,size),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRefreshButton(AzkarProvider azkarProvider,int number,Size size)
  {
    if(isFinish[number])
      return Align(
        alignment: Alignment.topLeft,
        child: InkWell(
          onTap: (){
            setState(() {
              isFinish[number]=false;
              counter[number]=0;
            });
          },
          child: Icon(
            Icons.refresh,
            color: isFinish[number] ? ruby[400] : ruby[600],
          ),
        ),
      ); 
    else 
      return SizedBox(
        height: 22,
      ); 
  }

  Widget _buildTextZekr(AzkarProvider azkarProvider,int number,Size size)
  {
    return Text(
      _isDiacriticsOpen ? 
        azkarProvider.getZekr(number).textWithDiacritics
        : azkarProvider.getZekr(number).textWithoutDiacritics,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: isFinish[number] ? ruby[400] : ruby[900],
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildBottomWidget(AzkarProvider azkarProvider,int number,Size size)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: _buildNumberOfAzkar(azkarProvider,number+1,size)
          ),
          if(counter[number]!=0)
            Align(
              alignment: Alignment.center,
              child: _buildCounter(azkarProvider,number,size)
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: (){
                setState(() {
                  showSanad[number] ? showSanad[number]=false : showSanad[number]=true;
                });
              },
              child: Icon(
                showSanad[number] ? Icons.info : Icons.info_outline,
                color: isFinish[number] ? ruby[400] : ruby[600],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberOfAzkar(AzkarProvider azkarProvider,int number,Size size)
  {
    return Container(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        'الذكر $number من ${azkarProvider.length}',
        style: new TextStyle(
          color: ruby[400],
          fontSize: 14,
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
        color: isFinish[index] ? ruby[100] : ruby[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          azkarProvider.getZekr(index).sanad,
          style: new TextStyle(
            color: isFinish[index] ? ruby[400] : ruby[600],
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildCounter(AzkarProvider azkarProvider,int numberZekr,Size size)
  {
    return Container(
      padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 15.0,right: 15.0),
      decoration: BoxDecoration(
        color: isFinish[numberZekr] ? ruby[300] : ruby[500],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        '${counter[numberZekr]} / ${azkarProvider.getZekr(numberZekr).counterNumber}',
        style: new TextStyle(
          color: isFinish[numberZekr] ? ruby[400] : ruby[100],
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildNumberRepetitions(AzkarProvider azkarProvider,int numberZekr,Size size)
  {
    return Container(
      padding: EdgeInsets.only(top: 5.0,bottom: 5.0,left: 15.0,right: 15.0),
      child: Text(
        azkarProvider.getZekr(numberZekr).counterText==null ?
        'مرة واحدة' : azkarProvider.getZekr(numberZekr).counterText,
        style: new TextStyle(
          color: isFinish[numberZekr] ? ruby[400] : ruby[700],
          fontSize: 12,
        ),
      ),
    );
  }

}
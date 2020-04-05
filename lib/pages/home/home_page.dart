import 'package:flutter/material.dart';
import '../../utilities/colors.dart';

class HomePage extends StatelessWidget 
{
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        _buildBackgroundImage(size),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'الصفحة الرئيسية',
              style: new TextStyle(
                color: ruby10,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: Column(
            children: <Widget>[
              _buildSearchBar(size),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            _buildItemsCard(size,'أسماء الله الحسني','assets/images/icons/favorites/icons-01-256px.png'),
                            _buildItemsCard(size,'المسبحة','assets/images/icons/sebha/sebha-128px.png'),
                            _buildItemsCard(size,'المفضلة','assets/images/icons/favorites/icons-02-256px.png'),
                          ],
                        ),
                      ),
                      _buildColumnCategories(size),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBackgroundImage(Size size)
  {
    return Container(
      color: ruby10,
      child: Image.asset(
        'assets/images/background/background.png',
        color: Color(0x1044000D),
        fit: BoxFit.cover,
        height: size.height,
      ),
    );
  }

  Widget _buildSearchBar(Size size)
  {
    return InkWell(
      onTap: (){
        print('You click on search');
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
            color: ruby80,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: ruby10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(
                  'إبحث عن ذكر . . . ',
                  style: TextStyle(
                    color: ruby30,
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

  Widget _buildItemsCard(Size size,String text,String pathIcon)
  {
    return Column(
      children: <Widget>[
        Card(
          color: ruby30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding:  EdgeInsets.all(5.0),
              height: size.height*0.1,
              width: size.width*0.15,
              child: Image.asset(
                pathIcon,
                // color: Color(0x1044000D),
                fit: BoxFit.contain,
                height: size.height,
              ),
            ),
          ),
        ),
        Container(
          width: size.width*0.18,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: new TextStyle(
              color: ruby,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumnCategories(Size size)
  {
    List<String> names=[
      'أذكار الصباح و المساء',
      'أذكار الوضوء والصلاة',
      'أذكار المرض والموت',
      'أذكار السفر',
      'أذكار الحج والعمرة',
      'أذكار المحن والسرور',
      'أذكار الحماية والايمان',
      'حياة شخصية ',
    ];
    return Column(
      children: <Widget>[
        _buildRowCategories(size,names.sublist(0,2),'assets/images/categories/0.png','assets/images/categories/1.png'),
        _buildRowCategories(size,names.sublist(2,4),'assets/images/categories/2.png','assets/images/categories/3.png'),
        _buildRowCategories(size,names.sublist(4,6),'assets/images/categories/4.png','assets/images/categories/5.png'),
        _buildRowCategories(size,names.sublist(6,8),'assets/images/categories/6.png','assets/images/categories/7.png'),
      ],
    );
  }

  Widget _buildRowCategories(Size size,List<String> names,String path1,String path2)
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCategoryCard(size,names[0],path1),
          _buildCategoryCard(size,names[1],path2),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(Size size,String text,String pathIcon)
  {
    return Card(
      color: ruby30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Container(
              padding:  EdgeInsets.all(5.0),
              height: size.height*0.2,
              width: size.width*0.4,
              child: Image.asset(
                pathIcon,
                fit: BoxFit.contain,
                height: size.height,
              ),
            ),
            Container
            (
              width: size.width*0.4,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  color: ruby,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
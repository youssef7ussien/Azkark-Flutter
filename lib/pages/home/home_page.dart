import '../../utilities/navigate_between_pages/scale_route.dart';
import '../../utilities/navigate_between_pages/slide_route.dart';
import '../../pages/settings/settings_page.dart';
import '../../pages/asmaallah/view_asmaallah.dart';
import '../../pages/prayer/view_prayer.dart';
import '../../pages/categories/all_categories.dart';
import '../../pages/favorites/view_favorites.dart';
import '../../pages/sebha/items_sebha.dart';
import '../../utilities/background.dart';
import '../../models/section_model.dart';
import '../categories/categories_of_section.dart';
import '../../providers/sections_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utilities/colors.dart';

class HomePage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final sectionsProvider=Provider.of<SectionsProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'الصفحة الرئيسية',
              style: new TextStyle(
                color: ruby[50],
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
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: size.height*0.25,
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: _buildItemsCard(size,'المفضلة','assets/images/icons/favorites/favorite_256px.png',context),
                            ),
                          _buildItemsCard(size,'المسبحة الإلكترونية','assets/images/icons/sebha/sebha_256px.png',context),
                            _buildItemsCard(size,'دعاء من القرآن','assets/images/icons/prayer/prayer_256px.png',context),
                          _buildItemsCard(size,'أسماء الله الحسني','assets/images/icons/asmaallah/allah_256px.png',context),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: _buildItemsCard(size,'الضبط','0',context),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: _buildAllAzkarCard(size,'عرض كل الأذكار',context),
                      ),
                      for(int i=0 ; i<sectionsProvider.length ; i+=2)
                        _buildRowCategories(sectionsProvider,size,i,context),
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

  Widget _buildSearchBar(Size size)
  {
    return InkWell(
      onTap: ()  {
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
                  'إبحث عن ذكر . . . ',
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

  Widget _buildItemsCard(Size size,String text,String pathIcon,BuildContext context)
  {
    return Column(
      children: <Widget>[
        Card(
          color: ruby[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          child: InkWell(
            highlightColor: ruby[400],
            borderRadius: BorderRadius.circular(10),
            onTap: (){
              print('You Clicked on $text');
              if(text=='المسبحة الإلكترونية')
                Navigator.push(context,ScaleRoute(page: ItemsSebha()),);

              else if(text=='المفضلة')
                Navigator.push(context,ScaleRoute(page: FavoritesView()),);

              else if(text=='دعاء من القرآن')
                Navigator.push(context,ScaleRoute(page: ViewPrayer()),);

              else if(text=='أسماء الله الحسني')
                Navigator.push(context,ScaleRoute(page: ViewAsmaAllah()),);

              else if(text=='الضبط')
                Navigator.push(context,ScaleRoute(page: Settings()),);
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              height: size.height*0.1,
              width: size.width*0.15,
              child: pathIcon=='0' ? Icon(
                Icons.settings,
                color: ruby[700],
                size: size.width*0.12,
              ) : Image.asset(
                pathIcon,
                fit: BoxFit.contain,
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

  Widget _buildAllAzkarCard(Size size,String text,BuildContext context)
  {
    return Card(
      color: ruby[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: InkWell(
        highlightColor: ruby[400],
        borderRadius: BorderRadius.circular(10),
        onTap: (){
          Navigator.push(context,SlideRightRoute(page: ViewAllCategories()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 5.0),
                height: size.height*0.06,
                child: Image.asset(
                  'assets/images/sections/8_128px.png',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: ruby,
                    fontWeight: FontWeight.w700,
                    fontSize: size.width*0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRowCategories(SectionsProvider sectionsProvider,Size size,int index,BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCategoryCard(
            size,
            sectionsProvider.getSection(index),
            context
          ),
          _buildCategoryCard(
            size,
            sectionsProvider.getSection(index+1),
            context
          ),
        ],
      ),
    );
  }
  

  Widget _buildCategoryCard(Size size,SectionModel sectionModel,BuildContext context)
  {
    return Card(
      color: ruby[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: size.height*0.25,
        width: size.width*0.45,
        child: InkWell(
          highlightColor: ruby[400],
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            print(sectionModel.categoriesIndex.length);
            Navigator.push(context,SlideRightRoute(page: CategoriesOfSection(sectionModel.id)),);
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding:  EdgeInsets.all(5.0),
                    // height: size.height*0.15,
                    width: size.width*0.4,
                    child: Image.asset(
                      'assets/images/sections/'+sectionModel.id.toString()+'.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  sectionModel.name,
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                    color: ruby,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
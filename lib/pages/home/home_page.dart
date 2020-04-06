import '../../models/section_model.dart';
import '../categories/categories_of_section.dart';

import '../../providers/categories_provider.dart';
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
    final sectionProvider=Provider.of<SectionsProvider>(context,listen: false);
    final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);

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
                      for(int i=0 ; i<sectionProvider.length ; i+=2)
                        _buildRowCategories(categoriesProvider,size,sectionProvider,i,context),
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

  Widget _buildRowCategories(CategoriesProvider categoriesProvider,Size size,SectionsProvider sectionsProvider,int index,BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildCategoryCard(
            categoriesProvider,
            size,
            sectionsProvider.getSection(index),
            'assets/images/sections/'+sectionsProvider.getSection(index).id.toString()+'.png',
            context
          ),
          _buildCategoryCard(
            categoriesProvider,
            size,
            sectionsProvider.getSection(index+1),
            'assets/images/sections/'+sectionsProvider.getSection(index+1).id.toString()+'.png',
            context
          ),
        ],
      ),
    );
  }
  

  Widget _buildCategoryCard(CategoriesProvider categoriesProvider,Size size,SectionModel sectionModel,String pathIcon,BuildContext context)
  {
    return Card(
      color: ruby30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: size.height*0.25,
        width: size.width*0.45,
        child: InkWell(
          highlightColor: ruby40,
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            print(categoriesProvider.getCategoriesOfSection(sectionModel.id).length);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Directionality( // add this
                  textDirection: TextDirection.rtl,
                  child : CategoriesOfSection(categoriesProvider.getCategoriesOfSection(sectionModel.id),sectionModel.id)
                );
              }),
            );
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
                      pathIcon,
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
                    fontSize: 13,
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
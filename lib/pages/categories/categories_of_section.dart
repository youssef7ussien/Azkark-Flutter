import '../../providers/sections_provider.dart';

import '../../providers/categories_provider.dart';
import 'package:provider/provider.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';

class CategoriesOfSection extends StatelessWidget 
{
  List<int> _listId;
  int _sectionId;
  
  CategoriesOfSection(this._listId,this._sectionId);

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
              sectionProvider.getSection(_sectionId-1).name,
              style: new TextStyle(
                color: ruby10,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(left: 8.0,right: 8.0),
            child: ListView.builder(
              itemCount: _listId.length,
              itemBuilder:  (context, index){
                return _buildListTitleCategory(categoriesProvider.getCategory(_listId[index]).nameWithDiacritics,size);
              },
            ),
          ),
        ),
      ]
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

  Widget _buildListTitleCategory(String name,Size size)
  {
    return Card(
      color: ruby30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: size.height*0.1,
        width: size.width,
        child: InkWell(
          highlightColor: ruby40,
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            print('$name');
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    name,
                    style: new TextStyle(
                      color: ruby,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                    padding:  EdgeInsets.all(5.0),
                    child: Image.asset(
                      'assets/images/icons/favorites/icons-01-128px.png',
                      fit: BoxFit.contain,
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
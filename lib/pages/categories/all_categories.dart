import '../../utilities/colors.dart';
import '../../widgets/categories_widget/category.dart';
import '../../providers/categories_provider.dart';
import 'package:provider/provider.dart';
import '../../utilities/background.dart';
import 'package:flutter/material.dart';

class ViewAllCategories extends StatefulWidget 
{

  @override
  _ViewAllCategoriesState createState() => _ViewAllCategoriesState();
}

class _ViewAllCategoriesState extends State<ViewAllCategories> 
{
  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);

    return Stack(
      children: <Widget>[
        Background(),
        Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: Text(
              'كل الأذكار',
              style: new TextStyle(
                color: ruby[50],
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          body: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: categoriesProvider.length,
            itemBuilder:  (context, index){
              return Padding(
                padding: index==0 ? 
                  const EdgeInsets.only(top:5.0,left: 5.0,right: 5.0)
                  : index==categoriesProvider.length-1 ?
                  const EdgeInsets.only(bottom: 5.0,left: 5.0,right: 5.0)
                  : const EdgeInsets.only(left: 5.0,right: 5.0),
                child: Category(
                  categoriesProvider.getCategory(index),
                ),
              );
            }
          ),
        ),
      ]
    );
  }
}
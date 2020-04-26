// import '../../pages/azkar/view_azkar.dart';
import '../../pages/azkar/view_azkar.dart';
import '../../providers/azkar_provider.dart';
import '../../models/category_model.dart';
import '../../providers/categories_provider.dart';
import '../../utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget 
{
  final CategoryModel _category;
  
  Category(this._category);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> 
{
  int onFavorite;

  @override
  void initState() 
  {
    super.initState();
    onFavorite=widget._category.favorite;
  }

  @override
  Widget build(BuildContext context) 
  {
    final size=MediaQuery.of(context).size;
    final categoriesProvider=Provider.of<CategoriesProvider>(context,listen: false);
    final azkarProvider=Provider.of<AzkarProvider>(context,listen: false);

    return Card(
      color: ruby[300],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        width: size.width,
        child: InkWell(
          highlightColor: ruby[100],
          borderRadius: BorderRadius.circular(10),
          onTap: () async {
            print('${widget._category.nameWithDiacritics}');
            print('${categoriesProvider.getCategory(widget._category.id).azkarIndex}');
            await azkarProvider.initialAllAzkar(categoriesProvider.getCategory(widget._category.id).azkarIndex);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child : ViewAzkar(),
                );
              }),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _buildNameField(),
                ),
                _buildFavoriteButton(categoriesProvider)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField()
  {
    return Text(
      widget._category.nameWithDiacritics,
      style: new TextStyle(
        color: ruby,
        fontWeight: FontWeight.w700,
        fontSize: 13,
      ),
    );
  }

  Widget _buildFavoriteButton(CategoriesProvider categoriesProvider)
  {
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
            onFavorite==1 ? onFavorite=0 : onFavorite=1;
          });
          await categoriesProvider.updateFavorite(onFavorite,widget._category.id);
        },
        child: Container(
          height: 45,
          width: 45,
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
}
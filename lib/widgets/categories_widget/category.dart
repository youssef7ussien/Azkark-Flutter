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

    return Card(
      color: ruby30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: 60,
        width: size.width,
        child: InkWell(
          highlightColor: ruby20,
          borderRadius: BorderRadius.circular(10),
          onTap: (){
            print('${widget._category.nameWithDiacritics}');
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
        highlightColor: ruby40,
        splashColor: ruby40,
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          print('You clicked on Favorite');
          setState(() {
            onFavorite==1 ? onFavorite=0 : onFavorite=1;
          });
          await categoriesProvider.uptadeFavorite(onFavorite,widget._category.id);
        },
        child: Container(
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
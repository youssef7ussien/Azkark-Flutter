import '../database/database_helper.dart';
import '../models/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider with ChangeNotifier
{
  List<CategoryModel> _categories=List<CategoryModel>();
  DatabaseHelper databaseHelper=new DatabaseHelper();

  int get length => _categories.length;

  CategoryModel getCategory(int index)
  {
    return _categories[index];
  }

  Future<bool> updateFavorite(int favorite,int id) async
  {
    _categories[id].setFavorite(favorite);
    try
    {
      await databaseHelper.uptadeFavorite(favorite,id);
      print('uptadeFavorite : true');
      return true; 
    }
    catch(e)
    {
      print('uptadeFavorite e : $e');
      return false;
    }
  }

  Future<bool> initialAllCategories() async
  {
    try
    {
      List<Map<String,dynamic>> tempCategories=await databaseHelper.getAllCategories();
      print('tempCategories.length : ${tempCategories.length}');

      for(int i=0 ; i<tempCategories.length ; i++)
        _categories.add(CategoryModel.fromMap(tempCategories[i]));

      print('_categories.length : ${_categories.length}');
      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('Faild initialAllCategories');
      print('e : $e');
      return false;
    }
  }

}
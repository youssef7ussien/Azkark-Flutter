import '../database/database_helper.dart';
import '../models/category_model.dart';
import 'package:flutter/foundation.dart';

class CategoriesProvider with ChangeNotifier
{
  List<CategoryModel> _categories=List<CategoryModel>();
  DatabaseHelper databaseHelper=new DatabaseHelper();
  // bool _newUser=true;

  // bool get isNewUser => _newUser;

  int get length => _categories.length;

  CategoryModel getCategory(int index)
  {
    return _categories[index];
  }

  List<int> getCategoriesOfSection(int sectionId)
  {
    List<int> listId=List<int>();
    for(int i=0; i<length ; i++)
    {
      if(_categories[i].sectionId==sectionId)
        listId.add(i);
    }
    return listId;
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
      print('Faild initialAllSections');
      print('e : $e');
      return false;
    }
  }

}
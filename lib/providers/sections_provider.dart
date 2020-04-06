import 'package:azkark/database/database_helper.dart';
import 'package:azkark/models/section_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'categories_provider.dart';

class SectionsProvider with ChangeNotifier
{
  List<SectionModel> _sections=List<SectionModel>();
  DatabaseHelper databaseHelper=new DatabaseHelper();
  bool _newUser=true;

  bool get isNewUser => _newUser;

  int get length => _sections.length;

  SectionModel getSection(int index)
  {
    return _sections[index];
  }

  bool addSection(int id,String name)
  {
    try
    {
      _sections.add(SectionModel(id,name));
      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('addSection e : $e');
      return false;
    }
  }

  Future<bool> initialAllSections() async
  {
    try
    {
      List<Map<String,dynamic>> tempSections=await databaseHelper.getAllSections();
      print('tempSections.length : ${tempSections.length}');

      for(int i=0 ; i<tempSections.length ; i++)
        _sections.add(SectionModel.fromMap(tempSections[i]));

      print('_sections.length : ${_sections.length}');
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

  Future<bool> tryToGetData(BuildContext context) async 
  {
    bool doesUserExists=await databaseHelper.isFileExists();

    if(doesUserExists) 
    {
      print('_newUser = false');
      _newUser=false;
      return false;
    }

    _newUser=true;
      print('_newUser = true');
    notifyListeners();

    await initialAllSections();
    print('_initial');
    try 
    {
      await Provider.of<CategoriesProvider>(context,listen: false).initialAllCategories();
    }
    catch(e)
    {
      print('_initial e  : $e');
    }
    return true;
  }
}
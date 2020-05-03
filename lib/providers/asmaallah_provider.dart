import '../models/asmaallah_model.dart';
import '../database/database_helper.dart';
import 'package:flutter/foundation.dart';

class AsmaAllahProvider with ChangeNotifier
{
  List<AsmaAllahModel> _asmaallah=List<AsmaAllahModel>();
  DatabaseHelper databaseHelper=new DatabaseHelper();

  int get length => _asmaallah.length;

  AsmaAllahModel getAsmaAllah(int index)
  {
    return _asmaallah[index];
  }

  Future<bool> initialAllAsmaAllah() async
  {
    try
    {
      List<Map<String,dynamic>> tempAsmaallah=await databaseHelper.getAllAsmaAllah();

      for(int i=0 ; i<tempAsmaallah.length ; i++)
        _asmaallah.add(AsmaAllahModel.fromMap(tempAsmaallah[i]));

      print('_asmaallah.length : ${_asmaallah.length}');
      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('Faild initialAllAsmaAllah');
      print('e : $e');
      return false;
    }
  }

}
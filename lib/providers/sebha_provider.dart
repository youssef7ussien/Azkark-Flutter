import '../database/database_helper.dart';
import '../models/sebha_model.dart';
import 'package:flutter/foundation.dart';

class SebhaProvider with ChangeNotifier
{
  List<SebhaModel> _sebha=List<SebhaModel>();
  DatabaseHelper databaseHelper=new DatabaseHelper();

  int get length => _sebha.length;

  SebhaModel getItemSebha(int index)
  {
    return _sebha[index];
  }

  Future<bool> initialAllItemsOfSebha() async
  {
    try
    {
      List<Map<String,dynamic>> tempSebha=await databaseHelper.getAllItemsOfSebha();
      print('tempSebha.length : ${tempSebha.length}');

      for(int i=0 ; i<tempSebha.length ; i++)
        _sebha.add(SebhaModel.fromMap(tempSebha[i]));

      print('_sebha.length : ${_sebha.length}');
      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('Faild initialAllItemsOfSebha');
      print('e : $e');
      return false;
    }
  }

}
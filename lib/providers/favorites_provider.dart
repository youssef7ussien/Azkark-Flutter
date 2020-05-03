import '../database/database_helper.dart';
import '../models/favorite_model.dart';
import 'package:flutter/foundation.dart';

class FavoritesProvider with ChangeNotifier
{
  Map<String,List<FavoriteModel>> _favorites=Map<String,List<FavoriteModel>>();
  DatabaseHelper databaseHelper=new DatabaseHelper();
  List<String> _tables=['favorites_categories', 'favorites_prayer','favorites_tasbih'];

  int length(int tableIndex) => _favorites[_tables[tableIndex]].length;
  
  bool isEmpty(int tableIndex) => _favorites[_tables[tableIndex]].isEmpty;

  int lastId(int tableIndex) 
  {
    return _favorites[_tables[tableIndex]].isEmpty ?
      -1 : _favorites[_tables[tableIndex]][length(tableIndex)-1].id; 
  }

  int getItemId(int tableIndex,int index)
  {
    return _favorites[_tables[tableIndex]][index].itemId;
  }

  FavoriteModel getFavorite(int tableIndex,int index)
  {
    return _favorites[_tables[tableIndex]][index];
  }

  Future<bool> addFavorite(int tableIndex,int itemId) async
  {
    try
    {
      await databaseHelper.addFavorite(
        _tables[tableIndex],
        FavoriteModel(lastId(tableIndex)+1,itemId),
      );
      _favorites[_tables[tableIndex]].add(FavoriteModel(lastId(tableIndex)+1,itemId));
      print('addFavorite');
      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('Faild addFavorite');
      print('e : $e');
      return false;
    }
  }

  Future<bool> deleteFavorite(int tableIndex,int itemId) async
  {
    try
    {
      await databaseHelper.deleteFavorite(_tables[tableIndex],itemId);
      for(int i=0 ; i<_favorites[_tables[tableIndex]].length ; i++)
        if(_favorites[_tables[tableIndex]][i].itemId==itemId)
        {
          _favorites[_tables[tableIndex]].removeAt(i);
          break;
        }
        
      print('deleteFavorite');
      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('Faild addFavorite');
      print('e : $e');
      return false;
    }
  }

  Future<bool> initialAllFavorites() async
  {
    try
    {
      Map<int,List<Map<String,dynamic>>> tempFavorites=Map<int,List<Map<String,dynamic>>>();
      for(int i=0 ; i<_tables.length ; i++)
      {
        _favorites[_tables[i]]=List<FavoriteModel>();
        tempFavorites[i]=List<Map<String,dynamic>>();
        tempFavorites[i]=await databaseHelper.getAllFavorite(_tables[i]);

        for(int j=0 ; j<tempFavorites[i].length ; j++)
          _favorites[_tables[i]].add(FavoriteModel.fromMap(tempFavorites[i][j]));
        
        print('_favorites[${_tables[i]}].length : ${_favorites[_tables[i]].length}');
      }

      notifyListeners();
      return true;
    }
    catch(e)
    {
      print('Faild initialAllFavorites');
      print('e : $e');
      return false;
    }
  }

}
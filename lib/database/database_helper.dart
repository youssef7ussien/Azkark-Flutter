import 'dart:io';
import 'package:azkark/models/favorite_model.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper
{
  static final DatabaseHelper _instance=new DatabaseHelper.internal();
  DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  Database _database;

  Future<Database> get database async
  {
    if(_database!=null)
      return _database;

    _database=await initialDatabase();
    return _database;
  }

  Future<bool> isFileExists()async
  {
    if(_database!=null)
      return true;
    
    _database=await initialDatabase();
    return false;
  }

  Future<Database> initialDatabase() async
  {
    Directory directory=await getApplicationDocumentsDirectory();
    String path=join(directory.path,'database.db');
    if(FileSystemEntity.typeSync(path)==FileSystemEntityType.notFound)
    {
      ByteData data=await rootBundle.load(join('assets','database.db'));
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes); 

      await new File(path).writeAsBytes(bytes);
    }
    return await openDatabase(path);
  } 

  Future<List<Map<String,dynamic>>> getAllSections() async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM sections');

    print('getAllSections done : ${result.length} ');
    return result;
  }
  
  Future<List<Map<String,dynamic>>> getAllCategories() async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM categories');

    print('getAllCategories done : ${result.length} ');
    return result;
  }

  Future<List<Map<String,dynamic>>> getAllItemsOfSebha() async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM tasbih');

    print('getAllItemsOfSebha done : ${result.length} ');
    return result;
  }

  Future<int> updateFavoriteInTables(String tableName,int favorite,int id) async 
  {
    var dbClient=await database;
    int result=await dbClient.rawUpdate('UPDATE $tableName SET favorite=$favorite WHERE id=$id');

    print('uptadeFavoriteIn $tableName : $result');
    return result; 
  }

  Future<List<Map<String,dynamic>>> getAllFavorite(String tableName) async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM $tableName');

    print('getAllFavorite done : ${result.length}');
    return result;
  }
  
  Future<int> addFavorite(String tableName,FavoriteModel favorite) async 
  {
    var dbClient=await database;
    int result=await dbClient.insert(tableName,favorite.toMap());
    print('addFavorite : $result');
    return result; 
  }
  
  Future<int> deleteFavorite(String tableName,int itemId) async 
  {
    var dbClient=await database;
    int result=await dbClient.rawDelete('DELETE FROM $tableName WHERE item_id=$itemId');

    print('deleteFavorite : $result');
    return result; 
  }

  Future<List<Map<String,dynamic>>> getAllAzkar(String azkarIndex) async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM azkar WHERE id IN ($azkarIndex)');

    print('getAllAzkar done : ${result.length}');
    return result;
  }

  Future<List<Map<String,dynamic>>> getAllPrayer() async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM prayer');

    print('getAllPrayer done : ${result.length}');
    return result;
  }
  
  Future<List<Map<String,dynamic>>> getAllAsmaAllah() async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM asmaallah');

    print('getAllAsmaAllah done : ${result.length}');
    return result;
  }
  
  Future<List<Map<String,dynamic>>> getSettings() async
  {
    var dbClient=await database;
    List<Map<String,dynamic>> result=await dbClient.rawQuery('SELECT * FROM settings');

    print('getAllAsmaAllah done : ${result.length}');
    return result;
  }

  Future<int> updateSettings(String nameField,dynamic value) async 
  {
    var dbClient=await database;
    int result=await dbClient.rawUpdate('UPDATE settings SET $nameField=$value WHERE id=0');

    print('updateSettings : $result');
    return result; 
  }
  
}
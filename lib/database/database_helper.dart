import 'dart:io';
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

  Future<int> uptadeFavorite(int favorite,int id) async 
  {
    var dbClient=await database;
    int result=await dbClient.rawUpdate('UPDATE categories SET favorite=$favorite WHERE id=$id');
    
    print('uptadeFavorite : $result');
    return result; 
  }


}
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;
import '../models/device_contact.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  static Database _db;

  factory DatabaseHelper(){
    return _instance;
  }

  Future<Database> get db async{
     if(_db != null){
       return _db;
     }
     _db = await initDb();
     
          return _db;
       }
     
       DatabaseHelper.internal();

  initDb() async {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path,"voca.db");
      var vocaDb = await openDatabase(path,version:1,onCreate: _onCreate);
      return vocaDb;
  }

  void _onCreate(Database db,int version) async{
    String initializationQuery = "CREATE TABLE SyncedContact(id INTEGER PRIMARY KEY, DisplayName TEXT, PhoneNumber TEXT)";
    await db.execute(initializationQuery);
    print("Database initialized");
  }

  Future<int> saveSyncedContact(DeviceContact _syncedContact) async{
    var dbClient = await db;
    int result  = await dbClient.insert("SyncedContact", _syncedContact.toMap());
    return result; 
  }
     
       
}
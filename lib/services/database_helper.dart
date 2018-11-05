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
    String syncedContactCreationQuery = "CREATE TABLE SyncedContact(id INTEGER PRIMARY KEY, DisplayName TEXT, PhoneNumber TEXT)";
    String vocaMessagesQuery = "CREATE TABLE VocaMessages(id INTEGER PRIMARY KEY, Sender TEXT, Recipient TEXT, TimeSent TEXT,TimeReceived TEXT)";
    await db.execute(syncedContactCreationQuery).then((result){
         db.execute(vocaMessagesQuery);
    });

    print("Database initialized");
  }

  Future<int> saveSyncedContact(DeviceContact _syncedContact) async{

    print(_syncedContact.displayName + 'ENTERING DB');
    var dbClient = await db;
    int result  = await dbClient.insert("SyncedContact", _syncedContact.toMap());

    print('RESULT OF ENTRY: '+result.toString());
    return result; 
  }
     
       
}
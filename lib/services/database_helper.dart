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

  
  // Future<List> getAllNotes() async {
  //   var result = await db.query(tableNote, columns: [columnId, columnTitle, columnDescription]);
  
  //   return result.toList();
  // }

  Future<List<DeviceContact>> retrieveSyncedContact() async{

    print('FETCHING FROM DB');
    List<DeviceContact> savedSyncedContacts = [];
    var dbClient = await db; 
    var result  = await dbClient.query("SyncedContact", columns: ['id','DisplayName','PhoneNumber']);

    result.toList().forEach((res){
     DeviceContact contact = DeviceContact.fromMap(res);
     savedSyncedContacts.add(contact);
     print(contact.nameLeadingAlphabet+' ===>> '+contact.displayName);
    });
   
    return  savedSyncedContacts; 
  }

  Future<DeviceContact> getContact(String _phoneNumber) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query("SyncedContact",
        columns: ["PhoneNumber"],
        where: 'PhoneNumber = ?',
        whereArgs: [_phoneNumber]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote WHERE $columnId = $id');
 
    if (result.length > 0) {
      return  DeviceContact.fromMap(result.first);
    }
 
    return null;
  }
     
       
}
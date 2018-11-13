import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;
import '../models/device_contact.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();

  static Database _db;

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "voca.db");
    var vocaDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return vocaDb;
  }

  void _onCreate(Database db, int version) async {
    String syncedContactCreationQuery =
        "CREATE TABLE SyncedContact(id INTEGER PRIMARY KEY, DisplayName TEXT, PhoneNumber TEXT)";
    String vocaMessagesQuery =
        "CREATE TABLE VocaMessages(id INTEGER PRIMARY KEY, Sender TEXT, Recipient TEXT, TimeSent TEXT,TimeReceived TEXT)";
    await db.execute(syncedContactCreationQuery).then((result) {
      db.execute(vocaMessagesQuery);
    });

    print("Database initialized");
  }

  Future<int> saveSyncedContact(List<DeviceContact> _syncedContacts) async {
    print(' is ENTERING DB');

    List<DeviceContact> availableSyncedContacts = [];
    List<DeviceContact> newContacts = [];
    List<DeviceContact> incomingContacts = _syncedContacts;

    var result;

    db.then((db) {
      var dbClient = db;
      retrieveSyncedContact().then((data) {
        bool alreadyExists = false;
        availableSyncedContacts = data;
        DeviceContact incomingContact;

        if (availableSyncedContacts.length > 0) {
          incomingContacts.forEach((incomingCon) {
            availableSyncedContacts.forEach((syncContact) {
              incomingContact = incomingCon;
              print(incomingCon.phoneNumberComparableValue + "against" + syncContact.phoneNumberComparableValue);
              if (syncContact.phoneNumberComparableValue ==
                  incomingContact.phoneNumberComparableValue) {
                alreadyExists = true;
              }
            });
            if (!alreadyExists) {
              newContacts.add(incomingContact);
            }
          });

          newContacts.forEach((contact){
            dbClient.insert("SyncedContact", contact.toMap()).then((data) {
              result = data;
              print('RESULT OF ENTRY: ' + result.toString());
            });
          });
        } else {
          _syncedContacts.forEach((data) {
            dbClient.insert("SyncedContact", data.toMap()).then((data) {
              result = data;
              print('RESULT OF ENTRY: ' + result.toString());
            });
          });
        }
      });
    });

    // getContact(_syncedContact.phoneNumber).then((result) {
    //   existingContact = result;
    //   if (existingContact == null) {
    //     dbClient
    //         .insert("SyncedContact", _syncedContact.toMap())
    //         .then((data) {});

    //     print('RESULT OF ENTRY: ' + result.toString());
    //     return result;
    //   } else {
    //     print(_syncedContact.displayName + ' already exists in the DB');
    //     return 0;
    //   }
    // });
  }

  // Future<List> getAllNotes() async {
  //   var result = await db.query(tableNote, columns: [columnId, columnTitle, columnDescription]);

  //   return result.toList();
  // }

  Future<List<DeviceContact>> retrieveSyncedContact() async {
    print('FETCHING FROM DB');
    List<DeviceContact> savedSyncedContacts = [];
    var dbClient = await db;
    var result = await dbClient
        .query("SyncedContact", columns: ['id', 'DisplayName', 'PhoneNumber']);

    result.toList().forEach((res) {
      DeviceContact contact = DeviceContact.fromMap(res);
      savedSyncedContacts.add(contact);
      print(contact.nameLeadingAlphabet + ' ===>> ' + contact.displayName);
    });

    return savedSyncedContacts;
  }

  Future<DeviceContact> getContact(String _phoneNumber) async {
    var dbClient = await db;
    var result;
    // List<Map> result = await dbClient.query("SyncedContact",
    //     columns: ["PhoneNumber"],
    //     where: 'PhoneNumber = ?',
    //     whereArgs: [_phoneNumber]);
    //var result = await dbClient.rawQuery('SELECT * FROM SyncedContact WHERE PhoneNumber = $_phoneNumber');
    dbClient
        .rawQuery(
            'SELECT * FROM SyncedContact WHERE PhoneNumber = $_phoneNumber')
        .then((data) {
      result = data;
      print('database result:');
      print(result);
    });

    if (result == null) {
      return null;
    }

    return DeviceContact.fromMap(result.first);
  }
}

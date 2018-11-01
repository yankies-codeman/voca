import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:async';

class ContactService {
  static ContactService _contactService;

  ContactService();

  getInstance() {
    if (_contactService == null) {
      _contactService = new ContactService();
    }
    return _contactService;
  }

  Future<Iterable<Contact>> getAllContacts() async {
    // Get all contacts
    Iterable<Contact> results = await ContactsService.getContacts();
    return results;
  }

  Future<bool> syncContacts() async {
    bool result = false;
    Iterable<Contact> deviceContacts;

    var vocaUserContacts = Firestore.instance.collection('VocaUsers').toString();

    print(vocaUserContacts.length);

     getAllContacts().then((results){
       deviceContacts = results;
        print(deviceContacts.length);
     });

  // for(var i = 0, i < deviceContacts.length, ){
    
  // }

    return result;
  }
}

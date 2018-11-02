import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'dart:async';
import '../models/device_contact.dart';

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
    // Get all contacts   Future<Iterable<Contact>> await async
    List<DeviceContact> deviceContacts = [];
    Iterable<Contact> contacts = await ContactsService.getContacts().then((data){
           data.forEach((contact){
            print( contact.displayName);
            print(contact.phones.forEach);
           });
    });
    
    // Iterable<Contact> results = [];
    //   ContactsService.getContacts().then((data){
    //     print(data);
    //   });

    // .then((data) {
    //   results = data;
    // });
    print(contacts);
    return contacts;
  }

  syncContacts() {
    bool result = false;
    Iterable<Contact> deviceContacts = [];
    List<String> fireStoreContacts = [];

    //data.documents.forEach((doc) => print(doc["FirstName"]));
    Firestore.instance.collection('VocaUsers').snapshots().listen((data) {
        data.documents.forEach((doc) {
          print(doc["FirstName"]);
          print(doc["PhoneNumber"]);
          String _phoneNumber = doc["PhoneNumber"];
          if(_phoneNumber != null){
            fireStoreContacts.add(_phoneNumber);
          }     
        });
     
        getAllContacts().then((results) {
          deviceContacts = results;
          print(results);
        });

          print(fireStoreContacts);
    });

    return result;
  }
}

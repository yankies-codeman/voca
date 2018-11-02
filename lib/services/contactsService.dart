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

  Future<List<DeviceContact>> getAllContacts() async {
    // Get all contacts   Iterable<Contact> contacts =
    List<DeviceContact> allDeviceContacts = [];

    await ContactsService.getContacts().then((data) {
      data.forEach((contact) {
        String currentContactName = contact.displayName;

        contact.phones.forEach((phoneNumber) {
          if (phoneNumber != null) {
            bool numberExistsInList = false;

            //CHECKING FOR DUPLICATE CONTACTS
            allDeviceContacts.forEach((phoneNumberInDeviceList) {
              if (phoneNumber.value == phoneNumberInDeviceList.phoneNumber) {
                numberExistsInList = true;
              }
            });

            if (!numberExistsInList) {
              DeviceContact currentDeviceContact = new DeviceContact();
              currentDeviceContact.displayName = currentContactName;
              currentDeviceContact.phoneNumber = phoneNumber.value
                  .toString()
                  .replaceAll(new RegExp(r"\s+\b|\b\s"), "");
              allDeviceContacts.add(currentDeviceContact);
              print(currentDeviceContact.displayName);
              print(currentDeviceContact.phoneNumber);
            }
          }
        });
      });
    });

    return allDeviceContacts;
  }

  Future<List<String>> getFirestoreContacts() async {
    List<String> fireStoreContacts = [];

    //data.documents.forEach((doc) => print(doc["FirstName"]));
    await Firestore.instance.collection('VocaUsers').snapshots().listen((data) {
      data.documents.forEach((doc) {
        print(doc["FirstName"]);
        print(doc["PhoneNumber"]);
        String _phoneNumber = doc["PhoneNumber"];
        if (_phoneNumber != null) {
          fireStoreContacts.add(_phoneNumber);
        }
      });
      //print(fireStoreContacts);
    });

    return fireStoreContacts;
  }

 Future<bool> syncContacts() async {
    bool result = false;
    List<DeviceContact> deviceContacts = [];
    List<String> fireStoreContacts = [];
    List<DeviceContact> syncedContacts = [];

    getAllContacts().then((allDeviceContacts) {
      deviceContacts = allDeviceContacts;
      //print(deviceContacts);
      getFirestoreContacts().then((allFireStoreContacts) {
        fireStoreContacts = allFireStoreContacts;
        //print(fireStoreContacts);
  
        //BRAIN OF SYNCING
        deviceContacts.forEach((devContact){
            fireStoreContacts.forEach((fireContact){
              if(devContact.phoneNumber == fireContact){
                DeviceContact commonContact = new DeviceContact();
                commonContact.phoneNumber = devContact.phoneNumber; //+233
                commonContact.displayName = devContact.displayName;
                syncedContacts.add(commonContact);

                print(commonContact.displayName);
                print(commonContact.phoneNumber);
              }
            });
        });

        result = true;
      });
    });

    return result;
  }
}

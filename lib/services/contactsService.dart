import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';

import 'dart:async';
import '../models/device_contact.dart';
import '../models/firestore_contact.dart';


class ContactService {
  static ContactService _contactService;

  ContactService();

  getInstance() {
    if (_contactService == null) {
      _contactService = new ContactService();
    }
    return _contactService;
  }

  getComparableValue(String _number){
    String result = '';
      if(_number != null){
        if(_number.startsWith('+')){
          result = _number.substring(4);
        }
        else if(_number.startsWith('0')){
            result = _number.substring(1);
        }
       else{
         result = _number;
       }
      }
      else
      {
       result = _number;
      }       
        print(result);
        return result;
  }

  Future<List<DeviceContact>> getAllDeviceContacts() async {
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
                         
              String currentDeviceContactDisplayName = currentContactName;
              String currentDeviceContactNumber = phoneNumber.value
                  .toString()
                  .replaceAll(new RegExp(r"\s+\b|\b\s"), "");
              String currentDeviceContactPhoneNumberComparableValue = getComparableValue(currentDeviceContactNumber);

              DeviceContact currentDeviceContact = new DeviceContact(currentDeviceContactDisplayName,currentDeviceContactNumber,currentDeviceContactPhoneNumberComparableValue);
              allDeviceContacts.add(currentDeviceContact);
              print(currentDeviceContact.displayName+ ": "+ currentDeviceContact.phoneNumber);
            }
            else{
              print(' this number exists : ' + phoneNumber.value);
            }
          }
        });
      });

        print('Device contacts are in!');
    });

    return allDeviceContacts;
  }

 Future<List<FirestoreContact>> getFirestoreContacts() async{
    List<FirestoreContact> fireStoreContacts = [];

     
    // FirebaseFirestoreSettings settings = new FirebaseFirestoreSettings.Builder()
    //     .setTimestampsInSnapshotsEnabled(true)
    //     .build();
    // firestore.setFirestoreSettings(settings);

    /*TO LISTEN FOR CHANGES TO A DOCUMENT*/
    //   Firestore.instance.collection('VocaUsers').snapshots().listen((data) {
    //   data.documents.forEach((doc) {
    //     print("Firestore => "+ doc["FirstName"]+": "+doc["PhoneNumber"]);
    //     String _phoneNumber = doc["PhoneNumber"];
    //     if (_phoneNumber != null) {
    //       fireStoreContacts.add(_phoneNumber);
    //     }
    //   });
    //   print('FireStore contacts are in!');
    // });

      await Firestore.instance.collection('VocaUsers').getDocuments().then((data){
        data.documents.forEach((doc) {
        print("Firestore => "+ doc["FirstName"]+": "+doc["PhoneNumber"]);
        String _phoneNumber = doc["PhoneNumber"];
        if (_phoneNumber != null) {
          FirestoreContact currentFirestoreContact = new FirestoreContact();
          currentFirestoreContact.phoneNumber = _phoneNumber;
          currentFirestoreContact.phoneNumberComparableValue =  getComparableValue(_phoneNumber);
          fireStoreContacts.add(currentFirestoreContact);   
        }
      });
         print('FireStore contacts are in!');
      });

    

    return fireStoreContacts;
  }

  Future<bool> syncContacts() async {
    bool result = false;
    List<DeviceContact> deviceContacts = [];
    List<FirestoreContact> fireStoreContacts = [];
    List<DeviceContact> syncedContacts = [];

    getAllDeviceContacts().then((allDeviceContacts) {
      
      deviceContacts = allDeviceContacts;
       
      getFirestoreContacts().then((allFireStoreContacts) {
     
        fireStoreContacts = allFireStoreContacts;

        print(allFireStoreContacts);
        print('got into the this part');

        if(allDeviceContacts != null && allFireStoreContacts != null){
          //BRAIN OF SYNCING
        deviceContacts.forEach((devContact) {
             
          fireStoreContacts.forEach((fireContact) {
           
            print(devContact.displayName + "("+ devContact.phoneNumberComparableValue+ ")" ' : Against : ' + fireContact.phoneNumberComparableValue);

            if (devContact.phoneNumberComparableValue == fireContact.phoneNumberComparableValue) {
             
              String commonContactdisplayName = devContact.displayName;
              String commonContactphoneNumber = devContact.phoneNumber; //+233    
              String phoneNumberComparableValue = getComparableValue(commonContactphoneNumber);        

              DeviceContact commonContact = new DeviceContact(commonContactdisplayName,commonContactphoneNumber,phoneNumberComparableValue);
              syncedContacts.add(commonContact);

              print("Matched Contacts :=>> "+devContact.displayName+ "("+ devContact.phoneNumber+ ")" + 'and' +fireContact.phoneNumber);
              
            }
          });
        });


        print("<<ALL MATCHED CONTACTS>>");
        syncedContacts.forEach((con){
        
          print(con.displayName+"("+con.phoneNumber+")");
        });
         result = true;
        }
        else
        {
           result = false;
        } //end of IF
       
       
      });


    });

    return result;
  }
}

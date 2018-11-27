import '../services/database_helper.dart';
import '../models/emergency_contact.dart';

class EmergencyContactService {
  static EmergencyContactService _instance =
      new EmergencyContactService.internal();

  factory EmergencyContactService() {
    return _instance;
  }

  get getInstance {
    if (_instance != null) {
      return _instance;
    }
    _instance = new EmergencyContactService.internal();
    return _instance;
  }

  EmergencyContactService.internal();

  Future<bool> addNew(EmergencyContact contact) async {
    DatabaseHelper db = new DatabaseHelper();
    int result = await db.addEmergencyContact(contact);
    if (result > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<EmergencyContact>> getSavedEmergencyContacts() async {
    DatabaseHelper db = new DatabaseHelper();
    List<EmergencyContact> emergencyContacts = [];
    List<EmergencyContact> testEmergencyContacts = [];

    await db.retrieveEmergencyContacts().then((results) {
      if(results.length != 0){
        results.forEach((con){
          print(con.relationship);
        });
      }
      else{
        print("empyt emergency list");
      }
      emergencyContacts = results;
    });

    if (emergencyContacts.length != 0 && emergencyContacts != null) {
      emergencyContacts.forEach((contact) {
        print('Emergency =>> ' + contact.name +'['+contact.relationship.toString()+ ']');
      });
    }

    var t1 = EmergencyContact();
    t1.setName = 'Berta';
    t1.setPhoneNumber = '02345678';
    t1.setRelationship = 'Dog';

    var t2 = EmergencyContact();
    t2.setName = 'Bongo';
    t2.setPhoneNumber = '0234587678';
    t2.setRelationship = 'Dog';

    testEmergencyContacts.add(t1);
    testEmergencyContacts.add(t2);

    return emergencyContacts;
  }
}

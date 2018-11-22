import '../services/database_helper.dart';
import '../models/emergency_contact.dart';

class EmergencyContactService{
  static  EmergencyContactService _instance = new EmergencyContactService.internal();

  factory EmergencyContactService() {
    return _instance;
  }

   get getInstance{
    if (_instance != null) {
      return _instance;
    }
    _instance =  new EmergencyContactService.internal();
    return _instance;
  }

  EmergencyContactService.internal();

  Future<bool> addNew(EmergencyContact contact) async{
     DatabaseHelper db = new DatabaseHelper();
     int result = await db.addEmergencyContact(contact);
     if(result > 0){
       return true;
     }
     else{
       return false;
     }
  }

    Future<List<EmergencyContact>> getSavedEmergencyContacts() async {
    DatabaseHelper db = new DatabaseHelper();
    List<EmergencyContact> emergencyContacts = [];

    await db.retrieveEmergencyContacts().then((results) {
      emergencyContacts = results;
    });
    return emergencyContacts;
  }
}

import '../services/database_helper.dart';
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
}

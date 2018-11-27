import 'package:scoped_model/scoped_model.dart';
import '../models/device_contact.dart';
import '../models/emergency_contact.dart';

class VocaAppState extends Model {
  bool _isGettingContacts;
  bool _isSyncingContacts;
  bool _isFirstTimeUsage;
  bool _addNewEmergencyNumber;

  List<EmergencyContact> _emergencyContacts = [];
  List<DeviceContact> _syncedContacts = [];

  VocaAppState();

  set setAddingNewEmergencyNumber(bool value) {
    _addNewEmergencyNumber = value;
    notifyListeners();
  }

  set setIsFirstTimeUsage(bool value) {
    _isFirstTimeUsage = value;
    notifyListeners();
  }

  set setIsGettingContacts(bool value) {
    _isGettingContacts = value;
    notifyListeners();
  }

  set setIsSyncingContacts(bool value) {
    _isSyncingContacts = value;
    notifyListeners();
  }

  set setSyncedContacts(List<DeviceContact> syncedContacts) {
    _syncedContacts = [];
    _syncedContacts = syncedContacts;
    notifyListeners();
  }

  set setEmergencyContacts(List<EmergencyContact> value) {
    _emergencyContacts = value;
    notifyListeners();
  }

  bool get isGettingContacts => _isGettingContacts;
  bool get isSyncingContacts => _isSyncingContacts;
  bool get isFirstTimeUsage => _isFirstTimeUsage;
  bool get isAddingNewEmergencyNumber => _addNewEmergencyNumber;

  List<EmergencyContact> get savedEmergencyContacts => _emergencyContacts;
  List<DeviceContact> get syncedContacts => _syncedContacts;
}

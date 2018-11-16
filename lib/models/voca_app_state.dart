import 'package:scoped_model/scoped_model.dart';
import '../models/device_contact.dart';

class VocaAppState extends Model {
  bool _isGettingContacts;
  bool _isSyncingContacts;
  bool _isFirstTimeUsage;

  List<DeviceContact> _syncedContacts = [];

  VocaAppState();

  set setIsFirstTimeUsage(bool value){
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

  bool get isGettingContacts => _isGettingContacts;
  bool get isSyncingContacts => _isSyncingContacts;
  bool get isFirstTimeUsage  => _isFirstTimeUsage;

  List<DeviceContact> get syncedContacts => _syncedContacts;
}

import 'package:scoped_model/scoped_model.dart';

class VocaAppState extends Model {
  bool _isgettingContacts;

  VocaAppState(this._isgettingContacts);

  set setIsgettingContacts(bool value) {
    _isgettingContacts = value;
    notifyListeners();
  }

  bool get isgettingContacts => _isgettingContacts;
}

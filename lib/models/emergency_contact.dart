class EmergencyContact{
  String _name;
  String _phoneNumber;
  String _relationship;

  EmergencyContact();

  String get name => _name;
  String get phoneNumber => _phoneNumber;
  String get relationship => _relationship;
  String get nameLeadingAlphabet => _name[0];

  set setName(String value){
    _name = value;
  }

  set setPhoneNumber(String value){
    _phoneNumber = value;
  }

  set setRelationship(String value){
    _relationship = value;
  }
}
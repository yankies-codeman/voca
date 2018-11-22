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

   Map<String,dynamic> toMap (){
     var map = new  Map<String,dynamic>();
     map["Contact"] = _phoneNumber;
     map["Name"] = _name;
     map["Relationship"] = _relationship;
     return map;
  }

   EmergencyContact.fromMap(dynamic obj){
     this._phoneNumber = obj['Contact'];
     this._name = obj['Name'];
      this._relationship = obj['Relationship'];
  }
}
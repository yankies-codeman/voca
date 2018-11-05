class DeviceContact{
  String _displayName;
  String _phoneNumber;
  String _phoneNumberComparableValue;

  DeviceContact(this._displayName,this._phoneNumber,this._phoneNumberComparableValue);

  DeviceContact.fromMap(dynamic obj){
     this._displayName = obj['DisplayName'];
     this._phoneNumber = obj['PhoneNumber'];
  }

  String get displayName => _displayName;
  String get phoneNumber => _phoneNumber;
  String get phoneNumberComparableValue => _phoneNumberComparableValue;

  Map<String,dynamic> toMap (){
     var map = new  Map<String,dynamic>();
     map["DisplayName"] = _displayName;
     map["PhoneNumber"] = _phoneNumber;

     return map;
  }
}
class DeviceContact{
  String _displayName;
  String _phoneNumber;
  String _phoneNumberComparableValue;
  

  DeviceContact(this._displayName,this._phoneNumber,this._phoneNumberComparableValue);


  String get displayName => _displayName;
  String get phoneNumber => _phoneNumber;
  String get nameLeadingAlphabet => capitalize(_displayName)[0];
  String get phoneNumberComparableValue => _phoneNumberComparableValue;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  getComparableValue() {
    String result = '';
    if (_phoneNumber != null) {
      if (_phoneNumber.startsWith('+')) {
        result = _phoneNumber.substring(4);
      } else if (_phoneNumber.startsWith('0')) {
        result = _phoneNumber.substring(1);
      } else {
        result = _phoneNumber;
      }
    } else {
      result = _phoneNumber;
    }
    print(result);
    return result;
  }

  Map<String,dynamic> toMap (){
     var map = new  Map<String,dynamic>();
     map["DisplayName"] = _displayName;
     map["PhoneNumber"] = _phoneNumber;
     return map;
  }

   DeviceContact.fromMap(dynamic obj){
     this._displayName = obj['DisplayName'];
     this._phoneNumber = obj['PhoneNumber'];
  }

}
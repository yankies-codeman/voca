class DeviceContact{
  String displayName;
  String phoneNumber;
  String phoneNumberComparableValue;

  DeviceContact(this.displayName,this.phoneNumber,this.phoneNumberComparableValue);

  DeviceContact.map(dynamic obj){
    this.displayName = obj['DisplayName'];
     this.phoneNumber = obj['PhoneNumber'];
  }

  String get isplayName => displayName;

  Map<String,dynamic> toMap (){
    var map = new  Map<String,dynamic>();
    map["DisplayName"] = displayName;
     map["PhoneNumber"] = phoneNumber;

     return map;
  }
}
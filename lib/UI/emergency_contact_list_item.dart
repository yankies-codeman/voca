import 'package:flutter/material.dart';
import '../models/emergency_contact.dart';

class EmergencyContactListItem extends StatelessWidget {

final EmergencyContact _savedEmergencyContact;

  EmergencyContactListItem(this._savedEmergencyContact);

  @override
  Widget build(BuildContext context) {
   return ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.blue,
        child: new Text(_savedEmergencyContact.nameLeadingAlphabet.toString())
      ),
      title: new Text(_savedEmergencyContact.name.toString() + " (" + _savedEmergencyContact.relationship.toString() + ")"),
      subtitle: new Text(_savedEmergencyContact.phoneNumber.toString())
    );
  }
}
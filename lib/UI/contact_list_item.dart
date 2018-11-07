import 'package:flutter/material.dart';
import '../models/device_contact.dart';

class ContactListItem extends StatelessWidget {

final DeviceContact _savedSyncedContact;

  ContactListItem(this._savedSyncedContact);

  @override
  Widget build(BuildContext context) {
   return ListTile(
      leading: new CircleAvatar(
        CbackgroundColor: Colors.blue,
        child: new Text(_savedSyncedContact.nameLeadingAlphabet)
      ),
      title: new Text(_savedSyncedContact.displayName),
      subtitle: new Text(_savedSyncedContact.phoneNumber)
    );
  }
}
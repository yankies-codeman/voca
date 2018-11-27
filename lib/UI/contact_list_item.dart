import 'package:flutter/material.dart';
import '../models/device_contact.dart';

class ContactListItem extends StatelessWidget {

final DeviceContact _savedSyncedContact;
  ContactListItem(this._savedSyncedContact);

  @override
  Widget build(BuildContext context) {
   return ListTile(
      leading: new CircleAvatar(
        backgroundColor: Colors.blue,
        child: new Text(_savedSyncedContact.nameLeadingAlphabet.toString())
      ),
      title: new Text(_savedSyncedContact.displayName.toString()),
      subtitle: new Text(_savedSyncedContact.phoneNumber.toString()),
      onTap: (){},
    );
  }
}
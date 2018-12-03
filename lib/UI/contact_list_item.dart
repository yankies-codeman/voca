import 'package:flutter/material.dart';
import '../models/device_contact.dart';
import '../pages/chat_messages_page.dart';
import 'package:fluro/fluro.dart';
import '../services/navigation_service.dart';

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
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatMessagesPage(otherParticipantPhoneNumber: _savedSyncedContact.phoneNumber,toName: _savedSyncedContact.displayName,)));      
      },
    );
  }
}
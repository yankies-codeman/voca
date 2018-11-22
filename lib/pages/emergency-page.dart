import 'package:flutter/material.dart';
import '../models/emergency_contact.dart';
import '../models/voca_app_state.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ui/emergency_contact_list_item.dart';

class EmergencyPage extends StatefulWidget {

  EmergencyPage();
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  EmergencyContact contact;

  @override
  void initState() {
    contact = EmergencyContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    showEmptyMessage() {
      Widget emptyMessage = Center(
        child: Text('No stored contacts yet.'),
      );
      return emptyMessage;
    }

    buildContactList(List<EmergencyContact> contacts) {
      var emergencyContactListItems = new List<EmergencyContactListItem>();
      for (var contact in contacts) {
        emergencyContactListItems.add(new EmergencyContactListItem(contact));
      }
      return emergencyContactListItems;
    }

    showEmergencyContactList(List<EmergencyContact> contacts) {
      Widget contactList = ListView(
          //type: MaterialListType.twoLine,
          shrinkWrap: false,
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: buildContactList(contacts));
      return contactList;
    }

    showForm(bool showform){
      if(showform){
        
      }
    }

   

    return ScopedModelDescendant<VocaAppState>(
        builder: (context, child, model) => Column(
          children: <Widget>[
              Expanded(
                child: model.savedEmergencyContacts.length == 0
                    ? showEmptyMessage()
                    : showEmergencyContactList(model.savedEmergencyContacts),
              ),
            
            ]));
  }
}

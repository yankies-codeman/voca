import 'package:flutter/material.dart';
import '../models/emergency_contact.dart';
import '../models/voca_app_state.dart';
import 'package:scoped_model/scoped_model.dart';
import '../ui/emergency_contact_list_item.dart';

class EmergencyPage extends StatefulWidget {
  _EmergencyPageState createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
  EmergencyContact contact;
  List<DropdownMenuItem<String>> relationshipDropdownContent;

  initializeDropdown() {
    relationshipDropdownContent = [];
    DropdownMenuItem parentItem =
        DropdownMenuItem(child: Text("Parent"), value: "Parent");
    DropdownMenuItem siblingItem =
        DropdownMenuItem(child: Text("Sibling"), value: "Sibling");
    DropdownMenuItem gaurdianItem =
        DropdownMenuItem(child: Text("Gaurdian"), value: "Gaurdian");

    relationshipDropdownContent.add(parentItem);
    relationshipDropdownContent.add(siblingItem);
    relationshipDropdownContent.add(gaurdianItem);
  }

  @override
  void initState() {
    contact = EmergencyContact();
    super.initState();
    initializeDropdown();
  }

  @override
  Widget build(BuildContext context) {
    final nameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) {
        contact.setName = value;
      },
      decoration: InputDecoration(
          hintText: 'Full name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final phoneNumberTextField = TextField(
      keyboardType: TextInputType.number,
      autofocus: false,
      onChanged: (value) {
        contact.setPhoneNumber = value;
      },
      decoration: InputDecoration(
          hintText: 'Phone number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final relationshipDropDownButton = DropdownButton(
      value: Text("Relationship"),
      items: relationshipDropdownContent,
      onChanged: (value) {
        contact.setRelationship = value;
      },
    );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        //elevation: 5.0,
        child: MaterialButton(
          color: Colors.lightBlueAccent,
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {},
          child: Text('Add', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    var emergencyContactForm = Column(
      children: <Widget>[
        nameTextField,
        phoneNumberTextField,
        relationshipDropDownButton,
        saveButton
      ],
    );

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

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return emergencyContactForm;
        });

    return ScopedModelDescendant<VocaAppState>(
        builder: (context, child, model) => Column(children: <Widget>[
              Expanded(
                child: model.savedEmergencyContacts.length == 0
                    ? showEmptyMessage()
                    : showEmergencyContactList(model.savedEmergencyContacts),
              )
            ]));
  }
}

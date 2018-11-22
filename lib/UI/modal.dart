import 'package:flutter/material.dart';

import '../models/emergency_contact.dart';
import '../models/voca_app_state.dart';
import 'package:scoped_model/scoped_model.dart';



class Modal {
  mainBottomSheet(BuildContext context) {
    List<DropdownMenuItem<dynamic>> relationshipDropdownContent; // = new List<DropdownMenuItem<dynamic>>();
     
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

  var _relationships = ['Parent','Sibling','Gaurdian'];
  String _currentSelectedItem = null;

  EmergencyContact contact = EmergencyContact();

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

    final relationshipDropDownButton = DropdownButton<String>(
        items: _relationships.map((String dropDownStringItem){
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(dropDownStringItem)
          );
        }).toList(),
        onChanged: (value) {
          contact.setRelationship = value;
          _currentSelectedItem = value;
          print(value);
        },
        hint: Text('Relationship '),
        value: _currentSelectedItem,
        );

    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        //elevation: 5.0,
        child: RaisedButton(
          color: Colors.lightBlueAccent,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          // minWidth: 200.0,
          // height: 42.0,
          onPressed: () {
            print("submission of form");
          },
          child: Text('Add', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    var emergencyContactForm = ListView(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 24.0, right: 24.0),
      children: <Widget>[
        SizedBox(height: 20.0),
        nameTextField,
        SizedBox(height: 8.0),
        phoneNumberTextField,
        SizedBox(height: 10.0),
        Row(children: <Widget>[
          Container(
            child: Text('                       '),
          ),
          Center(child:relationshipDropDownButton ,)
        ],)
        ,
        //SizedBox(height: 24.0),
        saveButton
      ],
    );

    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Center(child: emergencyContactForm);
        });
  }
}

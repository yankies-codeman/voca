import 'package:flutter/material.dart';

import '../UI/emergencySubmitLoaderOverlay.dart';
import '../models/emergency_contact.dart';
import '../models/voca_app_state.dart';
import 'package:scoped_model/scoped_model.dart';
import '../services/emergency_contact_service.dart';

class EmergencyContactForm extends StatefulWidget {
  final Key scaffoldKey;
  final Function callback;
  EmergencyContactForm(this.scaffoldKey, this.callback);
  @override
  _EmergencyContactFormState createState() => _EmergencyContactFormState();
}

class _EmergencyContactFormState extends State<EmergencyContactForm> {
  EmergencyContact newEmergencyContact;
  List<String> _relationships;
  String _currentSelectedRelationShipItem;
  EmergencyContactService emergencyContactService;
  var _scaffoldKey;

  @override
  void initState() {
    super.initState();
    _scaffoldKey = widget.scaffoldKey;
    _relationships = ['Parent', 'Sibling', 'Gaurdian'];
    _currentSelectedRelationShipItem = null;
    emergencyContactService = EmergencyContactService();
    newEmergencyContact = EmergencyContact();
  }

  @override
  Widget build(BuildContext context) {
    var nameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value) {
        newEmergencyContact.setName = value;
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
        newEmergencyContact.setPhoneNumber = value;
      },
      decoration: InputDecoration(
          hintText: 'Phone number',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final relationshipDropDownButton = DropdownButton<String>(
      items: _relationships.map((String dropDownStringItem) {
        return DropdownMenuItem<String>(
            value: dropDownStringItem, child: Text(dropDownStringItem));
      }).toList(),
      onChanged: (value) {
        setState(() {
          this.newEmergencyContact.setRelationship = value;
          this._currentSelectedRelationShipItem = value;
          print(_currentSelectedRelationShipItem);
        });
      },
      hint: Text('Relationship '),
      value: _currentSelectedRelationShipItem,
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
          onPressed: saveEmergencyContact, //addNewEmergencyContact,
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
        Row(
          children: <Widget>[
            Container(
              child: Text('                       '),
            ),
            Center(
              child: relationshipDropDownButton,
            )
          ],
        ),
        saveButton,
        SizedBox(height: 150.0),
      ],
    );

    //  return ScopedModelDescendant<VocaAppState>(
    //         builder: (context, child, model) => Container(
    //             height: 700.0,
    //             child: Center(
    //                 child: Stack(
    //               fit: StackFit.expand,
    //               children: <Widget>[
    //                 model.isAddingNewEmergencyNumber == true
    //                     ? EmergencySubmitLoaderOverlay()
    //                     : Container(),
    //                 emergencyContactForm
    //               ],
    //             ))));

    return Container(height: 700.0, child: Center(child: emergencyContactForm));
  }

  saveEmergencyContact() async {
    setState(() {
      //currentAppState.setIsGettingContacts = true;
    });
    await emergencyContactService.addNew(newEmergencyContact).then((data) {
      print('add new call in modal form');
      widget.callback();
      Navigator.of(context).pop();
      if (data) {
        SnackBar snackBar = SnackBar(content: Text('Contact added!'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        SnackBar snackBar = SnackBar(content: Text("Error! Couldn't save."));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }
}

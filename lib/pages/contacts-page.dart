import 'package:flutter/material.dart';
import '../services/contactsService.dart';
import '../models/device_contact.dart';
import '../ui/contact_list_item.dart';
import '../models/voca_app_state.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactsPage extends StatefulWidget {
  final List<DeviceContact> refreshedContacts;

  ContactsPage(this.refreshedContacts);

  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<DeviceContact> _refreshedContacts;

  Widget loadingField = Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
            height: 36.0,
            width: 36.0,
            child: CircularProgressIndicator(
              value: null,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )),
        Text("Syncing! Please wait...")
      ],
    ),
  );

  buildContactList() {
    var contactListItems = new List<ContactListItem>();
    for (var contact in _refreshedContacts) {
      contactListItems.add(new ContactListItem(contact));
    }
    return contactListItems;
  }

  checkLoading(bool isGettingContacts) {
    if (isGettingContacts == true) {
      return loadingField;
    } else {
      return Container();
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshedContacts = widget.refreshedContacts;
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyMessage = Center(
      child: Text('No synced contacts yet. Tap the sync button.'),
    );

    Widget contactList = ListView(
        //type: MaterialListType.twoLine,
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: buildContactList());

    return ScopedModelDescendant<VocaAppState>(
      builder: (context, child, model) => Column(
            children: <Widget>[
              checkLoading(model.isgettingContacts),
              _refreshedContacts.length == 0 ? emptyMessage : contactList
            ],
          ),
    );

    // return Container(

    // );
  }
}

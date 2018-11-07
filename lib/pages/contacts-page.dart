import 'package:flutter/material.dart';
import '../services/contactsService.dart';
import '../models/device_contact.dart';
import '../ui/contact_list_item.dart';

class ContactsPage extends StatefulWidget {
final List<DeviceContact> refreshedContacts;
  // ContactsPage();
  // ContactsPage();

  ContactsPage(this.refreshedContacts);

  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<DeviceContact> _refreshedContacts;

  @override
  void initState() {
    super.initState();
    _refreshedContacts = widget.refreshedContacts;
  }

  @override
  Widget build(BuildContext context) {
    if (_refreshedContacts == null) {
      return Container(
        child: Center(
          child: Text('No synced contacts yet. Tap the sync button.'),
        ),
      );
    } else {
      return ListView(
          //type: MaterialListType.twoLine,
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _buildContactList());
    }
  }

  _buildContactList() {
    var contactListItems = new List<ContactListItem>();
    for (var contact in _refreshedContacts) {
      contactListItems.add(new ContactListItem(contact));
    }
    return contactListItems;
  }
}

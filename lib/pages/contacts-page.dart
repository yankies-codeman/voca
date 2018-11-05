import 'package:flutter/material.dart';
import '../services/contactsService.dart';

class ContactsPage extends StatefulWidget {

  // final RefreshContacts 
  // ContactsPage();
  // ContactsPage();


  _ContactsPageState createState() => _ContactsPageState(); 
}

class _ContactsPageState extends State<ContactsPage> {
 ContactService contactService;

@override
void initState() {
    super.initState();
    contactService = ContactService().getInstance();
  }

  @override
  Widget build(BuildContext context) {
     return Container(   
      child: Center(
        child:Text('Contacts Section'),
      ),
    );
  }
}
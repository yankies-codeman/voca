import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import '../services/SharedPrefSingleton.dart';
import '../services/contactsService.dart';
import '../services/emergency_contact_service.dart';

import '../pages/talk-page.dart';
import '../pages/messages-page.dart';
import '../pages/contacts-page.dart';
import '../pages/emergency-page.dart';
import '../models/device_contact.dart';
import '../models/voca_app_state.dart';
import '../ui/modal.dart';
import '../models/message_list_display_item.dart';
import '../models/emergency_contact.dart';
import '../UI/emergencySubmitLoaderOverlay.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

//TODO: ADD REFRESHED MESSAGES AND OTHER THINGS TO SCOPED MODEL
class _HomePageState extends State<HomePage> {
  int currentTab;
  bool contactsLoaded = false;
  VocaAppState currentAppState;
  SharedPrefSingleton prefs;
  TalkPage talkPage;
  MessagesPage messagesPage;
  ContactsPage contactsPage;
  EmergencyPage emergencyPage;
  List<Widget> pages;
  Widget currentPage;
  Modal emergencyContactModal;
  EmergencyContactService emergencyContactService = EmergencyContactService();
  ContactService contactService;
  List<DeviceContact> refreshedContacts;
  List<MessageListDisplayItem> refreshedMessages;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<String> _relationships;
  String _currentSelectedRelationShipItem;
  EmergencyContact newEmergencyContact;
  bool showLoader;

  int currentPageIndex;

  refreshPages() {
    setState(() {
      talkPage = null;
      messagesPage = null;
      emergencyPage = null;
      contactsPage = null;
      talkPage = new TalkPage();
      messagesPage = new MessagesPage(refreshedMessages);
      emergencyPage = new EmergencyPage();
      contactsPage = new ContactsPage();
      _relationships = ['Parent', 'Sibling', 'Gaurdian'];
      _currentSelectedRelationShipItem = null;
      newEmergencyContact = EmergencyContact();
      showLoader = false;

      pages = [talkPage, messagesPage, contactsPage, emergencyPage];
      currentTab = currentPageIndex;
      currentPage = pages[currentPageIndex];

      print(currentPage);
    });
  }

  syncContacts() async {
    setState(() {
      currentAppState.setIsSyncingContacts = true;
    });
    await contactService.syncContacts().then((data) {
      if (data == true) {
        setState(() {
          currentAppState.setIsSyncingContacts = false;
          getSavedContacts();
        });
        SnackBar snackBar = SnackBar(content: Text('Contacts sync complete!'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        setState(() {
          currentAppState.setIsSyncingContacts = false;
        });
        SnackBar snackBar =
            SnackBar(content: Text("Couldn't sync! Check connection."));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  getSavedContacts() async {
    setState(() {
      currentAppState.setIsGettingContacts = true;
    });
    await contactService.getSavedSyncedContacts().then((data) {
      setState(() {
        currentAppState.setSyncedContacts = data;
        currentAppState.setIsGettingContacts = false;
      });
    });
  }

  getSavedEmergencyContacts() async {
    setState(() {
      //currentAppState.setIsGettingContacts = true;
    });
    await emergencyContactService.getSavedEmergencyContacts().then((data) {
      setState(() {
        currentAppState.setEmergencyContacts = data;
        //currentAppState.setIsGettingContacts = false;
      });
    });
  }

  saveEmergencyContact() async {
    setState(() {
      //currentAppState.setIsGettingContacts = true;
    });
    await emergencyContactService.addNew(newEmergencyContact).then((data) {
      if (data) {
        getSavedEmergencyContacts();
        setState(() {
          //currentAppState.setEmergencyContacts = data;
          //currentAppState.setIsGettingContacts = false;
        });
        SnackBar snackBar = SnackBar(content: Text('Contact added!'));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      } else {
        SnackBar snackBar = SnackBar(content: Text("Error! Couldn't save."));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    });
  }

  getFirstTimeUsage() async {
    await prefs.getIsFirstTimeUsage().then((data) {
      currentAppState.setIsFirstTimeUsage = data;
      if (data) {
        syncContacts();
        prefs.setIsFirstTimeUsage(false);
      }
    });
  }

  @override
  initState() {
    super.initState();

    //TODO: Create a Message Service and Emergency Contact Service to interact with the DB(more like Repositories)
    emergencyContactService = EmergencyContactService();
    contactService = ContactService().getInstance();
    currentAppState = VocaAppState();
    prefs = SharedPrefSingleton().getInstance();

    getFirstTimeUsage();
    getSavedContacts();
    getSavedEmergencyContacts();
    currentPageIndex = 1;
    currentTab = currentPageIndex;
    refreshPages();
    currentAppState.setAddingNewEmergencyNumber = false;
  }

  @override
  Widget build(BuildContext context) {
    // return new  Scaffold(
    //   appBar: new AppBar(title: new Text('Voca'),centerTitle: true),
    //   body: Center(
    //     child: Container(
    //       child: new Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //            new Text('You are logged in now'),
    //            SizedBox(height: 48.0),
    //            new OutlineButton(
    //               borderSide: BorderSide(color: Colors.red, style: BorderStyle.solid, width: 3.0 ),
    //               child: new Text('Logout'),
    //               onPressed: (){
    //                 FirebaseAuth.instance.signOut().then((value){
    //                     prefs.clearPreferences();
    //                     Navigator.of(context).pushReplacementNamed('/');
    //                 }).catchError((e){

    //                 });
    //               },
    //            )
    //         ]
    //       ) ,),
    //       ),
    //       bottomNavigationBar: BottomNavigationBar(
    //         currentIndex: currentTab,
    //         onTap: (int index){
    //             setState(() {
    //             currentTab = index;
    //            });
    //         },
    //         items:<BottomNavigationBarItem>[
    //           BottomNavigationBarItem(
    //             icon: Icon(Icons.speaker),
    //             title:Text("Talk")),
    //             BottomNavigationBarItem(
    //             icon: Icon(Icons.mail),
    //             title:Text("Messages")),
    //             BottomNavigationBarItem(
    //             icon: Icon(Icons.account_box),
    //             title:Text("Contacts")),
    //             BottomNavigationBarItem(
    //             icon: Icon(Icons.explicit),
    //             title:Text("I.C.E")),
    //         ]
    //       ),
    // );

    final nameTextField = TextField(
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

    addNewEmergencyContact() {
      setState(() {
        showLoader = true;
        currentAppState.setAddingNewEmergencyNumber = true;
      });
      print(newEmergencyContact.phoneNumber);
      print(newEmergencyContact.name);
      print(newEmergencyContact.relationship);
      saveEmergencyContact();
      print(currentAppState.isAddingNewEmergencyNumber);
      print("submission of form");
      //Navigator.pop(context);
    }

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
          onPressed: addNewEmergencyContact,
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
        //SizedBox(height: 24.0),
        saveButton,
        SizedBox(height: 150.0),
      ],
    );

    _showEmergencyContactForm(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return Container(
                height: 700.0,
                child: Center(
                    child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    currentAppState.isAddingNewEmergencyNumber == true
                        ? EmergencySubmitLoaderOverlay()
                        : Container(),
                    emergencyContactForm
                  ],
                )));
          });
    }

    generateNavItem(IconData _icon, String _text) {
      return BottomNavigationBarItem(
          icon: Icon(
            _icon,
            color: Colors.blue,
            size: 30.0,
          ),
          title: Text(_text, style: new TextStyle(color: Colors.blue)));
    }

    changeFloatingAction() {
      IconData icon;
      Function fabAction;

      contactsPageFabAction() async {
        setState(() {
          currentAppState.setIsSyncingContacts = true;
        });
        syncContacts();
      }

      emergencyPageFabAction() {
        _showEmergencyContactForm(context);
      }

      messagesPageFabAction() {}

      if (currentPage == messagesPage) {
        icon = Icons.message;
        fabAction = () => messagesPageFabAction();
      } else if (currentPage == contactsPage) {
        if (currentAppState.isSyncingContacts == true) {
          return null;
        } else {
          icon = Icons.sync;
          fabAction = () => contactsPageFabAction();
        }
      } else if (currentPage == emergencyPage) {
        icon = Icons.add;
        fabAction = () => emergencyPageFabAction();
      }

      return FloatingActionButton(child: Icon(icon), onPressed: fabAction);
    }

    return ScopedModel<VocaAppState>(
        model: currentAppState,
        child: new Scaffold(
          key: _scaffoldKey,
          appBar: new AppBar(title: new Text('Voca'), centerTitle: true),
          body: currentPage,
          floatingActionButton:
              currentPage == talkPage ? null : changeFloatingAction(),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.shifting,
              fixedColor: Colors.blue,
              currentIndex: currentTab,
              onTap: (int index) {
                setState(() {
                  currentPageIndex = index;
                  currentTab = index;
                  currentPage = pages[index];
                });
              },
              items: <BottomNavigationBarItem>[
                generateNavItem(Icons.phonelink_ring, "Talk"),
                generateNavItem(Icons.message, "Messages"),
                generateNavItem(Icons.account_box, "Contacts"),
                generateNavItem(Icons.explicit, "I.C.E"),
              ]),
        ));
  }
}

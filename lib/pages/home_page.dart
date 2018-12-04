import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../services/shared_pref_service.dart';
import '../services/contacts_service.dart';
import '../services/emergency_contact_service.dart';
import 'dart:io';
//import 'package:flutter_tts/flutter_tts.dart';
//import 'package:simple_permissions/simple_permissions.dart';

import '../pages/talk_page.dart';
import '../pages/chats_page.dart';
import '../pages/contacts_page.dart';
import '../pages/emergency_page.dart';
import '../models/device_contact.dart';
import '../models/voca_app_state.dart';
import '../ui/emergency_contact_form.dart';


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
  ChatsPage chatsPage;
  ContactsPage contactsPage;
  EmergencyPage emergencyPage;
  List<Widget> pages;
  Widget currentPage;
  EmergencyContactService emergencyContactService;
  ContactService contactService;
  List<DeviceContact> refreshedContacts;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentPageIndex;

  refreshPages() {
    setState(() {
      talkPage = null;
      chatsPage = null;
      emergencyPage = null;
      contactsPage = null;
      talkPage = new TalkPage();
      chatsPage = new ChatsPage();
      emergencyPage = new EmergencyPage();
      contactsPage = new ContactsPage();

      pages = [talkPage, chatsPage, contactsPage, emergencyPage];
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
    print('We are getting the emergency contacts');
    setState(() {
      //currentAppState.setIsGettingContacts = true;
    });
    await emergencyContactService.getSavedEmergencyContacts().then((data) {
      setState(() {
        print('setting the state of E contact list!');
        currentAppState.setEmergencyContacts = data;
        //currentAppState.setIsGettingContacts = false;
      });
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
    //onPressed: (){
    //FirebaseAuth.instance.signOut().then((value){
    //prefs.clearPreferences();
    //Navigator.of(context).pushReplacementNamed('/');
    //}).catchError((e){
    //});

    _showEmergencyContactForm() {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return EmergencyContactForm(_scaffoldKey,getSavedEmergencyContacts);
          });
    }

    _showContactsInModal(){
     
       showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return chatsPage;
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
        print("emergency");
        currentAppState.setAddingNewEmergencyNumber = false;
        _showEmergencyContactForm();
      }

      messagesPageFabAction() {
      _showContactsInModal();
      }

      if (currentPage == chatsPage) {
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
                generateNavItem(Icons.message, "Chats"),
                generateNavItem(Icons.account_box, "Contacts"),
                generateNavItem(Icons.explicit, "I.C.E"),
              ]),
        ));
  }
}

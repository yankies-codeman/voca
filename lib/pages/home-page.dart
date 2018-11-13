import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/SharedPrefSingleton.dart';
import '../services/contactsService.dart';

import '../pages/talk-page.dart';
import '../pages/messages-page.dart';
import '../pages/contacts-page.dart';
import '../pages/emergency-page.dart';
import '../models/device_contact.dart';
import '../models/voca_app_state.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/message_list_display_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab;
  bool contactsLoaded = false;
  VocaAppState currentAppState = VocaAppState(true);
  SharedPrefSingleton prefs;
  TalkPage talkPage;
  MessagesPage messagesPage;
  ContactsPage contactsPage;
  EmergencyPage emergencyPage;
  List<Widget> pages;
  Widget currentPage;
  ContactService contactService;
  List<DeviceContact> refreshedContacts;
  List<MessageListDisplayItem> refreshedMessages;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int currentPageIndex;

  refreshPages() {
    setState(() {
      talkPage = new TalkPage();
      messagesPage = new MessagesPage(refreshedMessages);
      emergencyPage = new EmergencyPage();

      contactsPage = new ContactsPage(refreshedContacts);

      pages = [talkPage, messagesPage, contactsPage, emergencyPage];
      currentTab = currentPageIndex;
      currentPage = pages[currentPageIndex];

      print(currentPage);
    });
  }

  @override
  initState() {
    super.initState();

    //TODO: Create a Message Service and Emergency Contact Service to interact with the DB(more like Repositories)
    contactService = ContactService().getInstance();
    prefs = SharedPrefSingleton().getInstance();
    contactService.getSavedSyncedContacts().then((data) {
      setState(() {
        refreshedContacts = data;
        currentAppState.setIsgettingContacts = false;
      });
      refreshPages();
    });
    currentPageIndex = 1;
    currentTab = currentPageIndex;
   
    refreshPages();
  }

  // refreshSavedContacts(){
  //    contactsPage = new ContactsPage();
  // }

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

      contactsPageFabAction() {
        setState(() {
          currentAppState.setIsgettingContacts = true;
        });
        contactService.syncContacts().then((data) {
          if (data == true) {
            setState(() {
              currentAppState.setIsgettingContacts = false;
            });
             SnackBar snackBar = SnackBar(content: Text('Contacts sync complete!'));
           _scaffoldKey.currentState.showSnackBar(snackBar);
          }          
        });
      }

      if (currentPage == messagesPage) {
        icon = Icons.message;
        fabAction = () => print("message fab tapped!");
      } else if (currentPage == contactsPage) {
        icon = Icons.sync;
        fabAction = () => contactsPageFabAction();
      } else if (currentPage == emergencyPage) {
        icon = Icons.add;
        fabAction = () => print("emergency fab tapped!");
      }
      if (currentAppState.isgettingContacts == true) {
        return null;
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
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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

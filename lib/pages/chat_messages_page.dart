import 'package:flutter/material.dart';
import 'package:fcm_push/fcm_push.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../UI/pec_editor.dart';
import '../services/shared_pref_service.dart';

class ChatMessagesPage extends StatefulWidget {
  final String chatID;
  final String otherParticipantPhoneNumber;
  final String toName;
  ChatMessagesPage(
      {this.chatID, this.otherParticipantPhoneNumber, this.toName});
  @override
  _ChatMessagesPageState createState() => _ChatMessagesPageState();
}

class _ChatMessagesPageState extends State<ChatMessagesPage> {
  String token;
  String chatID;
  String toName;
  SharedPrefSingleton sharedPref;
  String otherParticipantPhoneNumber;

  saveCacheDetails() async {
    print(chatID);
     print(otherParticipantPhoneNumber);
      print(toName);
       print(token);
    await sharedPref.setCurrentChatID(chatID);
    await sharedPref.setCurrentChatPartnerNumber(otherParticipantPhoneNumber);
    await sharedPref.setCurrentChatPartnerName(toName);
    Firestore.instance
        .collection('VocaUsers')
        .where("PhoneNumber", isEqualTo: otherParticipantPhoneNumber)
        .snapshots()
        .listen((data) {
      token = data.documents.single.data["DeviceFcmTokem"];
      print(token);
      sharedPref.setCurrentChatPartnerFcmToken(token);
    });

    //await sharedPref.setCurrentChatPartnerFcmToken(token);
  }

  @override
  void initState() {
    super.initState();
    otherParticipantPhoneNumber = widget.otherParticipantPhoneNumber;
    chatID = widget.chatID;
    toName = widget.toName;
    sharedPref = SharedPrefSingleton();
    saveCacheDetails();
  }

  @override
  Widget build(BuildContext context) {
    Widget chatMessgeList = StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('ChatMessages')
          .where("ChatID", isEqualTo: chatID)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text(
              'Loading...',
              style: TextStyle(fontSize: 30.0),
            );
          default:
            return new ListView(
              children:
                  snapshot.data.documents.map((DocumentSnapshot document) {
                return Text(document['Message'],);     
                              
                // Padding(
                //   padding: EdgeInsets.all(10),
                //   child: Text(
                //     document['Message'],
                //     style: TextStyle(fontSize: 20.0),
                //   ),
                // );
              }).toList(),
            );
        }
      },
    );

    Widget view = SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(child: chatMessgeList),
            Expanded(
              child: new PecEditor("ChatMessages"),
            )
          ], //pay attention to this
        ),
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text(toName),
      ),
      body: view,
    );
  }
}

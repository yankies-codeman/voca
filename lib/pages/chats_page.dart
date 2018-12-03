import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_list_display_item.dart';
import '../ui/chat_list_item.dart';
import '../services/shared_pref_service.dart';
import '../services/contacts_service.dart';

class ChatsPage extends StatefulWidget {
  ChatsPage();

  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  String myNumber;
  SharedPrefSingleton sharedPrefSingleton;
  ContactService contactService;
  getCurrentUserPhoneNumber() async {
    myNumber = await sharedPrefSingleton.getUserPhoneNumber();
  }

  @override
  void initState() {
    super.initState();
    sharedPrefSingleton = SharedPrefSingleton();
    contactService = ContactService();
    getCurrentUserPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('Chats')
          .where("From", isEqualTo: myNumber)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) {
          return Center(
            child: Text(
              'No chats.',
              style: TextStyle(fontSize: 30.0),
            ),
          );
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Loading...',
                  style: TextStyle(fontSize: 30.0),
                ),
              );
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {

                  String otherParticipantNumber;
                  String chatID = document['chatID'];
                  String partnerName = document['ToName'];
                  String time = document['Time'].toString();
                  document['From'] == myNumber
                      ? otherParticipantNumber = document['To']
                      : otherParticipantNumber = document['From'];

                  ChatListDisplayItem newChatDisplayItem =
                      getOtherParticipantDetails(
                          otherParticipantNumber, chatID, partnerName,time);
                  print(newChatDisplayItem);

                  return ChatListItem(newChatDisplayItem);
                }).toList(),
              );
          }
        }
      },
    );
  }

  getOtherParticipantDetails(
      String _otherParticipantNumber, String _chatID, String _partnerName,String _time) {
    String _lastMessage = "";
    String _unreadDisplay = "";
    String _lastMessageTime = "8:30";

     Firestore.instance
      .collection('ChatMessages')
      .where("ChatID", isEqualTo: _chatID)
      .snapshots()
      .listen((data) {
      _lastMessage = data.documents.last['Message'].toString();
      _lastMessageTime = data.documents.last['Time'].toString();
      print('test LAST MESSAGE');
      print(_lastMessage);
      print(_lastMessageTime);
    }).onError((error) {
      print(error.toString());
      _lastMessage = "error";
    });
    
    Firestore.instance
        .collection('ChatMessages')
        .where("IsRead", isEqualTo: 'false')
        .snapshots()
        .listen((data) {
      _unreadDisplay = data.documents.length.toString();
    }).onError((error) {
      print(error.toString());
      _lastMessage = "error";
    });

    String _senderName = _partnerName;
    print(_otherParticipantNumber);

    ChatListDisplayItem newChatListDisplayItem = ChatListDisplayItem(
        _otherParticipantNumber,
        _senderName,
        _lastMessage,
        _unreadDisplay,
        _lastMessageTime,
        _chatID);

    print(_senderName);

    return newChatListDisplayItem;
  }
}

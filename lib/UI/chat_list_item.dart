import 'package:flutter/material.dart';
import '../models/chat_list_display_item.dart';
import '../pages/chat_messages_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatListItem extends StatefulWidget {
  ChatListDisplayItem messageListDisplayItem;
  ChatListItem(this.messageListDisplayItem);

  _ChatListItemState createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem> {
  ChatListDisplayItem _chatListDisplayItem;

  getLastMessageDeatils() {
    Firestore.instance
        .collection('ChatMessages')
        .where("ChatID", isEqualTo: _chatListDisplayItem.chatID)
        .snapshots()
        .listen((data) {
      _chatListDisplayItem.setLastMessage =
          data.documents.last['Message'].toString();
      _chatListDisplayItem.setLastMessageTime =
          data.documents.last['Time'].toString();
      print('test LAST MESSAGE');
      print(_chatListDisplayItem.lastMessage);
      print(_chatListDisplayItem.lastMessageTime);
    }).onError((error) {
      print(error.toString());
      // _lastMessage = "error";
    });
  }

  @override
  void initState() {
    super.initState();
    _chatListDisplayItem = widget.messageListDisplayItem;
    print('sENCOND LAST MESSAGE');
    print(_chatListDisplayItem.lastMessage);
    getLastMessageDeatils();
  }

  @override
  Widget build(BuildContext context) {
    var extraInfo = Container(
      child: Column(
        children: <Widget>[
          Text(_chatListDisplayItem.lastMessageTime),
          Text(_chatListDisplayItem.unreadDisplay)
        ],
      ),
    );

    var basicTile = ListTile(
      leading: new CircleAvatar(
          backgroundColor: Colors.blue,
          child: new Text(_chatListDisplayItem.senderNameLeadingAlphabet)),
      title: new Text(_chatListDisplayItem.senderName),
      subtitle: new Text(_chatListDisplayItem.lastMessage), //new Text(_chatListDisplayItem.lastMessage),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatMessagesPage(
                      chatID: _chatListDisplayItem.chatID,
                      toName: _chatListDisplayItem.senderName,
                    )));
      },
    );

    // return Row(
    //   children: <Widget>[basicTile, extraInfo],
    // );

    return basicTile;
  }
}

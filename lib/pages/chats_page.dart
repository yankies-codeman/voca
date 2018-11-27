import 'package:flutter/material.dart';
import '../models/message_list_display_item.dart';
import '../ui/message_list_item.dart';

class ChatsPage extends StatefulWidget {
  final List<MessageListDisplayItem> messagesList;

  ChatsPage(this.messagesList);

  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List<MessageListDisplayItem> _messagesList;

  @override
  void initState() {
    super.initState();
    _messagesList = widget.messagesList;
  }

  @override
  Widget build(BuildContext context) {
    if (_messagesList == null) { //_messagesList.length == 0
      return Container(
        child: Center(
          child:
              Text("Tap the button to start a conversation."),
        ),
      );
    } else {
      return ListView(
          //type: MaterialListType.twoLine,
          padding: new EdgeInsets.symmetric(vertical: 8.0),
          children: _buildMessageList());
    }
  }

  _buildMessageList() {
    var messageListItems = new List<MessageListItem>();
    for (var messageItem in _messagesList) {
      messageListItems.add(new MessageListItem(messageItem));
    }
    return messageListItems;
  }
}

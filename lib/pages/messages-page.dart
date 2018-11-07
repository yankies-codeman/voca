import 'package:flutter/material.dart';
import '../models/message_list_display_item.dart';
import '../ui/message_list_item.dart';

class MessagesPage extends StatefulWidget {
  final List<MessageListDisplayItem> messagesList;

  MessagesPage(this.messagesList);

  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<MessageListDisplayItem> _messagesList;

  @override
  void initState() {
    super.initState();
    _messagesList = widget.messagesList;
  }

  @override
  Widget build(BuildContext context) {
    if (_messagesList == null) {
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

import 'package:flutter/material.dart';
import '../models/message_list_display_item.dart';

class MessageListItem extends StatefulWidget {
  final MessageListDisplayItem messageListDisplayItem;
  MessageListItem(this.messageListDisplayItem);

  _MessageDisplayListItemState createState() => _MessageDisplayListItemState();
}

class _MessageDisplayListItemState extends State<MessageListItem> {
  MessageListDisplayItem _messageListDisplayItem;

  @override
  void initState() {
    super.initState();
    _messageListDisplayItem = widget.messageListDisplayItem;
  }

  @override
  Widget build(BuildContext context) {
    var basicTile = ListTile(
        leading: new CircleAvatar(
            backgroundColor: Colors.blue,
            child: new Text(_messageListDisplayItem.senderNameLeadingAlphabet)),
        title: new Text(_messageListDisplayItem.senderName),
        subtitle: new Text(_messageListDisplayItem.lastMessageTime));
    
    var extraInfo = Container(
      child: Column(
        children: <Widget>[
          Text(_messageListDisplayItem.lastMessageTime),
          Text(_messageListDisplayItem.unreadDisplay)
        ],
      ),
    );

    return Row(
      children: <Widget>[
        basicTile,extraInfo
      ],
    );
  }
}

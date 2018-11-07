class MessageListDisplayItem{
  String _senderID;
  String _senderName;
  String _lastMessage;
  String _unreadDisplay;
  String _lastMessageTime;

  MessageListDisplayItem(this._senderID,this._senderName,this._lastMessage,this._unreadDisplay,this._lastMessageTime);

  String get senderNameLeadingAlphabet => _senderName[0];
  String get senderName => _senderName;
  String get lastMessage => _lastMessage;
  String get unreadDisplay => _unreadDisplay;
  String get lastMessageTime => _lastMessageTime;
  
}
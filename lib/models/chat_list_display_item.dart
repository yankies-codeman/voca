class ChatListDisplayItem{
  String _otherParticipantNumber;
  String _senderName;
  String _lastMessage;
  String _unreadDisplay;
  String _lastMessageTime;
  String _chatID;

  ChatListDisplayItem(this._otherParticipantNumber,this._senderName,this._lastMessage,this._unreadDisplay,this._lastMessageTime,this._chatID);

  String get senderNameLeadingAlphabet => _senderName[0];
  String get senderName => _senderName;
  String get lastMessage => _lastMessage;
  String get unreadDisplay => _unreadDisplay;
  String get lastMessageTime => _lastMessageTime;
  String get chatID => _chatID;

  set setLastMessage(String value){
    _lastMessage = value;
  }

   set setLastMessageTime(String value){
    _lastMessageTime = value;
  }
  
}
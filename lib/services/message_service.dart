import '../services/database_helper.dart';
class MessageService{
  static  MessageService _instance = new MessageService.internal();

  factory MessageService() {
    return _instance;
  }

   get getInstance{
    if (_instance != null) {
      return _instance;
    }
    _instance =  new MessageService.internal();
    return _instance;
  }

  MessageService.internal();
}

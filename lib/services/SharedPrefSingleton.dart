import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefSingleton{

  static SharedPrefSingleton _sharedPrefSingleton;

   SharedPrefSingleton();//Constructor

   getInstance(){
    if(_sharedPrefSingleton == null)
    {
     _sharedPrefSingleton = new SharedPrefSingleton();
    }
     return _sharedPrefSingleton;
  }

  //GETTERS
  Future<bool> getUserLoggedIn() async{
      SharedPreferences preferences = await SharedPreferences.getInstance(); 
      bool result = preferences.getBool("LoggedIn");
      if(result == null){
          return false;
      }
   return result;
  }

   Future<String> getUserPhoneNumber() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   String result = preferences.getString("PhoneNumber");  
   return result;
  }

   Future<String>getCurrentUserFirstName() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   String result = preferences.getString("FirstName");  
   return result;
  }

   Future<String>getCurrentUserLastname() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   String result = preferences.getString("LastName");  
   return result;
  }

  Future<String>getCurrentUserAge(String _age) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String result = preferences.getString("Age");  
    return result;
  }

  //SETTERS
   Future<bool> setUserLoggedIn() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setBool("LoggedIn",true);  
   return preferences.commit();
  }

   Future<bool> setUserPhoneNumber(String _phoneNumber) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setString("PhoneNumber",_phoneNumber);  
   return preferences.commit();
  }

   Future<bool>setCurrentUserFirstName(String _firstName) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setString("FirstName",_firstName);  
   return preferences.commit();
  }

   Future<bool>setCurrentUserLastname(String _lastName) async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.setString("LastName",_lastName);  
   return preferences.commit();
  }

    Future<bool>setCurrentUserAge(String _age) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("Age",_age);  
    return preferences.commit();
  }


  Future<bool> clearPreferences() async{
   SharedPreferences preferences = await SharedPreferences.getInstance();
   preferences.clear();  
   return preferences.commit();
  }



}
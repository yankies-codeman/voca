import 'package:flutter/material.dart';
import '../services/SharedPrefSingleton.dart';
import '../pages/login-page.dart';
import '../pages/home-page.dart';


class LandingPage extends StatefulWidget {
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

 bool isLoggedIn = false;
 bool sharedPrefResponseReceived = false;

  @override
  initState(){
    super.initState();
    initSharedPref();
    
  }

  initSharedPref(){
    SharedPrefSingleton prefs = SharedPrefSingleton().getInstance(); 
    prefs.getUserLoggedIn().then((result){
      print("Login status: ");
      print(result);
                setState(() {
                   isLoggedIn = result;
                   sharedPrefResponseReceived = true;
                });
            });
   }

  @override
  Widget build(BuildContext context) {
      
      if(sharedPrefResponseReceived)
      {
          return Container(
            child:  isLoggedIn ?  HomePage() : LoginPage(),
        );
      }
      else
      {
        return Container(
            child:  Center(

            ),
        );
      }
      
   
    
  }
}
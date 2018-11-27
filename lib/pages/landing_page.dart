import 'package:flutter/material.dart';
import '../services/shared_pref_service.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';


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

    // if (sharedPrefResponseReceived) {
    //   return SafeArea(
    //     child: Container(
    //       child: isLoggedIn ? HomePage() : LoginPage(),
    //     ),
    //     bottom: true,
    //     top: false,
    //     left: true,
    //     right: true,
    //   );
    // } else {
    //   return Container(
    //     child: Center(),
    //   );
    // }
      
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
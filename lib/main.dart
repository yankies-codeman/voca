import 'package:flutter/material.dart';
import './pages/login-page.dart';
import './pages/home-page.dart';
import './pages/landing-page.dart';
import './pages/signUp-page.dart';
import './services/navigation.dart';

import './UI/progress_button.dart';




void main() => runApp(new VocaApp());

class VocaApp extends StatelessWidget {
  // This widget is the root of your application.
   VocaApp() {
    Navigation.initPaths();
    
    // SharedPrefSingleton sps = SharedPrefSingleton().getInstance();
    // bool isLoggedIn = false;
    // sps.getUserLoggedIn().then((bool result){
    //   isLoggedIn = result;
    // });
  }

  @override
  Widget build(BuildContext context) {

    
    
     return new MaterialApp(
      title: 'Voca',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Nunito',
      ),
      home: LandingPage(),//SignUpPage(),
      onGenerateRoute: Navigation.router.generator,
    );
   

    //  return new MaterialApp(
    //   title: 'Voca',
    //   debugShowCheckedModeBanner: false,
    //   theme: new ThemeData(
    //     // This is the theme of your application.
    //     //
    //     // Try running your application with "flutter run". You'll see the
    //     // application has a blue toolbar. Then, without quitting the app, try
    //     // changing the primarySwatch below to Colors.green and then invoke
    //     // "hot reload" (press "r" in the console where you ran "flutter run",
    //     // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
    //     // counter didn't reset back to zero; the application is not restarted.
    //     primarySwatch: Colors.blue,
    //     fontFamily: 'Nunito',
    //   ),
    //   home: SignUpPage(),//LoginPage(),
    //   routes: <String, WidgetBuilder>{
    //     '/homepage': (BuildContext context) => HomePage(),
    //     '/signuppage': (BuildContext context) => SignUpPage(),
    //     '/landingpage': (BuildContext context) => LoginPage(),
    //   },
    // );


  //  return new MaterialApp(
  //     home: Scaffold(
  //       appBar: new AppBar(
  //         title: new Text("Test")
  //       ),
  //       body: new Center(
  //         child: ProgressButton()
  //       ),
  //   ),
  //  );
  }
}

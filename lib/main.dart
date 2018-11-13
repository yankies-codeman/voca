import 'package:flutter/material.dart';
import './pages/landing-page.dart';
import './services/navigation.dart';

// import './pages/login-page.dart';
// import './pages/home-page.dart';
// import './pages/signUp-page.dart';
// import './UI/progress_button.dart';

void main() => runApp(new VocaApp());

class VocaApp extends StatelessWidget {
  // This widget is the root of your application.
  VocaApp() {
    Navigation.initPaths();
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
      home: LandingPage(), //SignUpPage(),
      onGenerateRoute: Navigation.router.generator,
    );  
  }
}

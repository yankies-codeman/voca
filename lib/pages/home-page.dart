import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new  Scaffold(
      appBar: new AppBar(title: new Text('Dashboard'),centerTitle: true),
      body: Center(
        child: Container(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
               new Text('You are logged in now'),
               SizedBox(height: 48.0),
               new OutlineButton(
                  borderSide: BorderSide(color: Colors.red, style: BorderStyle.solid, width: 3.0 ),
                  child: new Text('Logout'),
                  onPressed: (){
                    FirebaseAuth.instance.signOut().then((value){
                        Navigator.of(context).pushReplacementNamed('/landingpage');
                    }).catchError((e){
                             
                    });
                  },
               )
            ]
          ) ,),),
    );
  }
}

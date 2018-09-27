import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final logo = new Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor : Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/images/robot.png'),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'julia@gmail.com',
      decoration: InputDecoration(
        hintText : 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText : 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
    );


    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius : BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          color:  Colors.lightBlueAccent,
          minWidth: 200.0,
          height : 42.0,
          onPressed: (){

          },         
          child: Text('Log In', style: TextStyle(color: Colors.white)),
        ),  
      ),
    );

    final forgotLabel = FlatButton(
      child: Text('Forgot Password?', style:  TextStyle(color: Colors.black54)),
      onPressed: (){},
    );

    final widgetSpace = SizedBox(height: 8.0);

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: ListView(
          shrinkWrap: true,
          padding : EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            widgetSpace,
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ]

        )
      ),
    );
  }
}
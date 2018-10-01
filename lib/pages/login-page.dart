import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    String _phoneNumber;
    String _smsCode;
    String _verificationId;

    Future<void> verifyPhone() async{

      final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verificationId){
        this._verificationId = verificationId;
      };

      final PhoneCodeSent smsCodeSent = (String verificationId,[int forceCodeResend]){
         this._verificationId = verificationId;

         smsCodeDialog(context).then((value){
           print('Signed In');
         });

      };

      final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
          print('veified');
      };

      final PhoneVerificationFailed verifiedFailed = (AuthException exception){
          print('${exception.message}');
      };

      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this._phoneNumber,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: verifiedFailed,
      );
    }

    Future<bool> smsCodeDialog(BuildContext context){
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text('Enter SMS code'),
            content: TextField(
              onChanged:(value){
                this._smsCode = value;
              }
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: (){
                  FirebaseAuth.instance.currentUser().then((user){
                    if(user !=null){
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/signuppage');
                    }
                    else{
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                }
              )
            ],
          );  
        } 
      );
    }

    signIn(){
      FirebaseAuth.instance.signInWithPhoneNumber(
        verificationId: _verificationId,
        smsCode: _smsCode
      ).then((user){
         Navigator.of(context).pushReplacementNamed('/signuppage');
      }).catchError((e){
        print(e);
      });
    }

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

    final phoneTextField = TextField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      onChanged: (value){
         _phoneNumber = value;
      },
      decoration: InputDecoration(
        hintText : 'Phone Number',
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
        //elevation: 5.0,
        child: MaterialButton(
          color:  Colors.lightBlueAccent,
          minWidth: 200.0,
          height : 42.0,
          onPressed: verifyPhone,         
          child: Text('Verify', style: TextStyle(color: Colors.white)),
        ),  
      ),
    );

    //final forgotLabel = FlatButton(
    //   child: Text('Forgot Password?', style:  TextStyle(color: Colors.black54)),
    //  onPressed: (){},
    //);

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: ListView(
          shrinkWrap: true,
          padding : EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            phoneTextField,
            SizedBox(height: 24.0),
            loginButton
          ]

        )
      ),
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../UI/loaderOverlay.dart';


class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {

    String _phoneNumber;
    String _smsCode;
    String _verificationId;
    bool showLoader = false;

    AnimationController _iconAnimationController;
    Animation <double> _iconAnimation;

  @override
  void initState(){
     super.initState();

     _iconAnimationController = new AnimationController(
       vsync: this,
       duration: new Duration(milliseconds: 500)
     );

     _iconAnimation = new CurvedAnimation(
       parent: _iconAnimationController,
       curve: Curves.bounceOut
     );

     _iconAnimation.addListener(() => this.setState((){}));
     _iconAnimationController.forward();
  }


    Future<void> verifyPhone() async{

      if(_phoneNumber.length == 13){

            final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verificationId){
              this._verificationId = verificationId;
            };

            final PhoneCodeSent smsCodeSent = (String verificationId,[int forceCodeResend]){
             
              print('Code has been sent');
              this._verificationId = verificationId;

              smsCodeDialog(context).then((value){
                print('Signed In');
              });

            };

            final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
                print('verified');
            };

            final PhoneVerificationFailed verifiedFailed = (AuthException exception){
                print('${exception.message}');
            };

            print("were here!"); 
            toggleLoader();
            
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: this._phoneNumber,
              codeAutoRetrievalTimeout: autoRetrieve,
              codeSent: smsCodeSent,
              timeout: const Duration(seconds: 5),
              verificationCompleted: verifiedSuccess,
              verificationFailed: verifiedFailed,
            ).then((value){
               print('after auth');
            });

      }
      else{
            print('number not up to 10');
              validationDialog(context);
      }     
    }

    toggleLoader(){
      bool nextLoaderValue;
      showLoader == true ? nextLoaderValue = false : nextLoaderValue = true;
      
      this.setState((){
        showLoader = nextLoaderValue;
      });
    }

    validationDialog(BuildContext context){
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return new AlertDialog(
                title: Text('Error!'),
                content: Text('Invalid phone number', style:TextStyle(fontSize: 30.0)),
                contentPadding: EdgeInsets.all(10.0),
                actions: <Widget>[
                  new FlatButton(
                    child: Text('Ok'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  )
                ],
              );  
            } 
          );
    }

        smsCodeErrorDialog(BuildContext context){
          return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return new AlertDialog(
                title: Text('Error!'),
                content: Text('The SMS code sent doesnt match what you entered.', style:TextStyle(fontSize: 30.0)),
                contentPadding: EdgeInsets.all(10.0),
                actions: <Widget>[
                  new FlatButton(
                    child: Text('Re-Enter'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    }
                  )
                ],
              );  
            } 
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
                    
                    print("firebase authentication done");
                    print(Firestore.instance.collection('VocaUsers').snapshots());
                    print(user);

                    //(snapshot.data.document[0]['fieldname'])

                  //CHECK IF THEIR DATA ALREADY EXISTS IN FIRESTORE DB AND REDIRECT THEM
                    if(user !=null){
                      //Navigator.of(context).pop();
                      //Navigator.of(context).pushReplacementNamed('/signuppage');
                    }
                    else{
                      smsCodeErrorDialog(context);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacementNamed('/signuppage');
                      //signIn();
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

           print('AT THE SIGNING IN PART');

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
        radius: _iconAnimation.value * 48.0,
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
          child: Text('Continue', style: TextStyle(color: Colors.white)),
        ),  
      ),
    );

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Scaffold(
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
        ),
       showLoader == true ?  LoaderOverlay(_phoneNumber) : Container()  
      ]
    );
  }
}
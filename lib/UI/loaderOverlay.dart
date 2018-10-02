import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoaderOverlay extends StatefulWidget {
 final   String _phoneNumber;

  LoaderOverlay(this._phoneNumber); 

  @override
  _LoaderOverlay createState() => _LoaderOverlay();
}

class _LoaderOverlay extends State<LoaderOverlay> with TickerProviderStateMixin {

 
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: null,//(){ print("Tapped");},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Container(
                child: CircularProgressIndicator()
              ),
              SizedBox(height: 48.0),
              Center(
                child: Text("A verification code will be sent \n to "+widget._phoneNumber+" very soon.",style: TextStyle(color: Colors.blue,fontSize: 20.0) )
              )
          ]
        )
      )
    );
  }
}
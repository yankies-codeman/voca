import 'package:flutter/material.dart';

class EmergencySubmitLoaderOverlay extends StatefulWidget {
  _EmergencySubmitLoaderOverlayState createState() => _EmergencySubmitLoaderOverlayState();
}

class _EmergencySubmitLoaderOverlayState extends State<EmergencySubmitLoaderOverlay> {
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
                child: Text("Adding contact!",style: TextStyle(color: Colors.blue,fontSize: 20.0) )
              )
          ]
        )
      )
    );
  }
}
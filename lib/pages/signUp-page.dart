import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _firstName;
  String _lastName;
  String _age;

  @override
 Widget build(BuildContext context) {

    final firstNameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value){
         _firstName = value;
      },
      decoration: InputDecoration(
        hintText : 'First Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
     
    );

    final lastNameTextField = TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (value){
         _lastName = value;
      },
      decoration: InputDecoration(
        hintText : 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
     
    );

    final ageTextField = TextField(
      keyboardType: TextInputType.number,
      autofocus: false,
      onChanged: (value){
         _age =  value;
      },
      decoration: InputDecoration(
        hintText : 'Age',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0)
        )
      ),
     
    );
 
    final saveButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius : BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        //elevation: 5.0,
        child: MaterialButton(
          color:  Colors.lightBlueAccent,
          
          minWidth: 200.0,
          height : 42.0,
          onPressed: null,         
          child: Text('Finish!', style: TextStyle(color: Colors.white)),
        ),  
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: ListView(
          shrinkWrap: true,
          padding : EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 48.0),
            firstNameTextField,
            SizedBox(height: 8.0),
            lastNameTextField,
            SizedBox(height: 8.0), 
            ageTextField,
            SizedBox(height: 24.0),
            saveButton
          ]

        )
      ),
    );
  }
}
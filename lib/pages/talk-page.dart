import 'package:flutter/material.dart';

class TalkPage extends StatefulWidget {
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  @override
  Widget build(BuildContext context) {
     return Container(   
      child: Center(
        child: InkWell(
          child: Center(
            child: Container(
              child:  Icon(Icons.speaker,size: 350,color: Colors.blue,),
            ),
          ),
            onTap: () => {},
        ),
      ),
    );
  }
}
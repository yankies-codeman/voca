import 'package:flutter/material.dart';
import '../ui/pec_editor.dart';

class TalkPage extends StatefulWidget {
  _TalkPageState createState() => _TalkPageState();
}

class _TalkPageState extends State<TalkPage> {
  @override
  Widget build(BuildContext context) {
    
    return PecEditor('Talk');

  }
}
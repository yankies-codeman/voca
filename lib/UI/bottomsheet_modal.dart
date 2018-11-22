import 'dart:async';
import 'package:flutter/material.dart';

class ModalBottomSheet extends StatefulWidget {
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet>
    with SingleTickerProviderStateMixin {
  var heightOfModalBottomSheet = 100.0;

  Widget build(BuildContext context) {
    return Container(
      height: heightOfModalBottomSheet,
      child: RaisedButton(
          child: Text("Press"),
          onPressed: () {
            heightOfModalBottomSheet += 100;
            setState(() {});
          }),
    );
  }
}
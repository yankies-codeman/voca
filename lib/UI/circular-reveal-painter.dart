import 'package:flutter/material.dart';
import 'dart:math';

class CircularRevealPainter extends CustomPainter{
  double _fraction;
  Size _screenSize;

  CircularRevealPainter(this._fraction,this._screenSize);

  @override
  void paint(Canvas canvas, Size size){

    var paint = Paint()
    ..style = PaintingStyle.fill
    ..color = Colors.blue;

    var finalRadius = pow((_screenSize.width/2),2) + pow((_screenSize.height/2),2)
    var radius = 24.0 + sqrt(finalRadius - 24 ) * _fraction;
    canvas.drawCircle(Offset(size.width/2,size.height/2), radius, paint);
  }

   @override
   bool shouldRepaint(CircularRevealPainter oldDelegate){
     return oldDelegate._fraction != _fraction;
   }

}
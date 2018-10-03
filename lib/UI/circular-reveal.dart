// import 'package:flutter/material.dart';
// import '../UI/circular-reveal-painter.dart';
// import 'dart:async';

// class CircularReveal extends StatefulWidget {
//   _CircularRevealState createState() => _CircularRevealState();
// }

// class _CircularRevealState extends State<CircularReveal> with TickerProviderStateMixin {
  
//   Animation _animation;
//   AnimationController _animationController;
//   double _fraction = 0.0;

//   @override
//   void initState(){
//     super.initState();

//     Timer(Duration(milliseconds: 3000),(){reveal();  });  
        
//  }
        
//         @override
//         Widget build(BuildContext context) {
//           return Center(
//             child: CustomPaint(
//               painter: CircularRevealPainter(_fraction,MediaQuery.of(context).size)
//               ),
//           );
//         }
      
//     void reveal() {   

//         _animationController = AnimationController(duration: Duration(milliseconds:300),vsync: this);
//         _animation = Tween(begin: 0.0, end: 1.0)
//         .animate(_animationController)
//         ..addListener((){
//           setState(() {
//                 _fraction = _animation.value;
//               });
//         });

//         _animationController.forward();
//   }
// }
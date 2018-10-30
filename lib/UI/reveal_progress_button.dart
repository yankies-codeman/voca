import 'package:flutter/material.dart';
import 'dart:async';
import '../models/voca_user.dart';
import 'package:fluro/fluro.dart';
import '../UI/progress_button.dart';
import '../UI/reveal_progress_button_painter.dart';
import '../navigation.dart';



class RevealProgressButton extends StatefulWidget {
  
  //Class variables
  VocaUser newUser;
  BuildContext context;

  //Constructor
  RevealProgressButton(this.newUser,this.context);

  @override
  State<StatefulWidget> createState() => _RevealProgressButtonState();
}

class _RevealProgressButtonState extends State<RevealProgressButton> with TickerProviderStateMixin {
   
  Animation<double> _animation;
  AnimationController _controller;
  double _fraction = 0.0;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RevealProgressButtonPainter(_fraction, MediaQuery.of(context).size),
      child: ProgressButton(reveal,widget.newUser,widget.context),
    );
  }

  @override
  void deactivate() {
    reset();
    super.deactivate();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void reveal() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      })
      ..addStatusListener((AnimationStatus state) {
        if (state == AnimationStatus.completed) {
          Navigation.navigateTo(context, '/homepage',
              transition: TransitionType.fadeIn);
        }
      });
    _controller.forward();
  }

  void reset() {
    _fraction = 0.0;
  }

}

// class RevealProgressButton extends StatefulWidget {
//   _CircularRevealState createState() => _CircularRevealState();
// }

// class _CircularRevealState extends State<RevealProgressButton> with TickerProviderStateMixin {
  
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
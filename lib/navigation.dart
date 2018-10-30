import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// import 'package:progress_button/page_two.dart';
// import 'package:progress_button/home_page.dart';

import './pages/login-page.dart';
import './pages/home-page.dart';
import './pages/signUp-page.dart';

class Navigation {
  static Router router;

  static void initPaths() {
    router = Router()
     ..define('/', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return LoginPage();
      }))
      ..define('/landingpage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return LoginPage();
      }))
      ..define('/signuppage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return SignUpPage();
      }))
      ..define('/homepage', handler: Handler(
          handlerFunc: (BuildContext context, Map<String, dynamic> params) {
        return HomePage();
      }));
      
  }

  static void navigateTo(
    BuildContext context,
    String path, {
    bool replace = false,
    TransitionType transition = TransitionType.native,
    Duration transitionDuration = const Duration(milliseconds: 250),
    RouteTransitionsBuilder transitionBuilder,
  }) {
    router.navigateTo(
      context,
      path,
      replace: replace,
      transition: transition,
      transitionDuration: transitionDuration,
      transitionBuilder: transitionBuilder,
    );
  }
}
import 'package:flutter/material.dart';

Route createRoute(Widget a) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => a,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

Route downRoute(Widget a) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => a,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route upRoute(Widget a) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => a,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

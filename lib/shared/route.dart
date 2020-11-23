import 'package:flutter/material.dart';

Route createRoute(Widget a) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => a,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

import 'package:flutter/material.dart';

class SildRightPageRouteWithCustomAnimation extends PageRouteBuilder {
  final Widget page;
  SildRightPageRouteWithCustomAnimation({required this.page})
      : super(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation1, animation2) => page,
            transitionsBuilder: (context, animation1, animation2, child) {
              final Animatable<Offset> tween =
                  Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero);
              // final Animation<Offset> offsetAnimation =
              //     animation1.drive<Offset>(tween);
              //? Animation
              final CurvedAnimation curvedAnimation =
                  CurvedAnimation(parent: animation1, curve: Curves.easeInOut);
              // return SlideTransition(position: offsetAnimation, child: child);
              return SlideTransition(
                  position: tween.animate(curvedAnimation), child: child);
            });
}

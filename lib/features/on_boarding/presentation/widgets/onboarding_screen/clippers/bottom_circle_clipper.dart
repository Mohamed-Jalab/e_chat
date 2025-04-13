import 'package:flutter/material.dart';

class BottomCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 65);
    path.quadraticBezierTo(
        size.width / 2, size.height + 40, size.width, size.height - 65);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

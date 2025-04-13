import 'package:flutter/material.dart';

class ColoredImageClipper extends CustomClipper<Path> {
  final double value;

  const ColoredImageClipper({super.reclip, required this.value});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(Rect.fromPoints(
        Offset(0, size.height), Offset(size.width, size.height * value)));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

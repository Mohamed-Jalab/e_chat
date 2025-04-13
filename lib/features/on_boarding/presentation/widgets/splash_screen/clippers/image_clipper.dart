import 'package:flutter/material.dart';

class ImageClipper extends CustomClipper<Path> {
  final double value;

  const ImageClipper({super.reclip, required this.value});
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.addRect(Rect.fromPoints(
        const Offset(0, 0), Offset(size.width, size.height * value)));
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

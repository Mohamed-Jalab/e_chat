import 'package:flutter/material.dart';

class SimiBottomCircleClipper extends CustomClipper<Path> {
  final double value1;
  final double value2;
  final bool circleClip;

  const SimiBottomCircleClipper({
    super.reclip,
    required this.value2,
    required this.value1,
    this.circleClip = false,
  });
  @override
  Path getClip(Size size) {
    Path path = Path();
    //-75
    if (!circleClip) {
      // ! value for animation
      path.lineTo(0, size.height - 25 - (value1 * 50));
      //! value for animation
      path.quadraticBezierTo(size.width / 2, size.height + 35, size.width,
          size.height - 75 + (value1 * 50));
      print("value1 =$value1");
    } else {
      print("value2 =$value2");
      path.lineTo(0, size.height - 50 - (value2 * 25));
      path.quadraticBezierTo(size.width / 2, size.height + 35, size.width,
          size.height - 50 + (value2 * 25));
    }
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

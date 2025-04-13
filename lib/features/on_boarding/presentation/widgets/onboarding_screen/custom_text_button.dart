import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onTap,
    this.backgroundColor = Colors.transparent,
    required this.title,
    this.foregroundColor = const Color(0xFF3AB2E8),
  });
  final void Function()? onTap;
  final Color backgroundColor;
  final String title;
  final Color foregroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: foregroundColor.withOpacity(.1),
      highlightColor: foregroundColor.withOpacity(.1),
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Ink(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              color: backgroundColor),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: foregroundColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
          )),
    );
  }
}
// Color(0xFF1B526B)
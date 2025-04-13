import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    this.onTap,
    required this.title,
    Color? backgroundColor,
    Color? foregroundColor,
    // this.backgroundColor = const Color(0xFFE8F0F9),
    // this.foregroundColor = const Color(0xFF1565C0),
    this.icon,
  })  : backgroundColor = backgroundColor ?? const Color(0xFFE8F0F9),
        foregroundColor = foregroundColor ?? const Color(0xFF1565C0);
  final Color backgroundColor;
  final Color foregroundColor;
  final void Function()? onTap;
  final IconData? icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        splashColor: foregroundColor.withOpacity(.1),
        highlightColor: foregroundColor.withOpacity(.1),
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Ink(
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(30))),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
          child: Text.rich(
            TextSpan(children: [
              if (icon != null)
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(icon, color: foregroundColor),
                  ),
                ),
              TextSpan(text: title)
            ]),
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: foregroundColor),
            // Text(
            //   "Register",
            //   style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w600,
            //       color: foregroundColor),
            // )
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({super.key, this.onTap, required this.icon});
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastLinearToSlowEaseIn,
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: onTap != null
                  ? [const Color(0xFF40C4FF), const Color(0xFF03A9F4)]
                  : [
                      const Color(0xFF40C4FF).withOpacity(.4),
                      const Color(0xFF03A9F4).withOpacity(.4)
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              splashColor: const Color(0xB01565C0),
              highlightColor: const Color(0xB01565C0),
              borderRadius: BorderRadius.circular(30),
              onTap: onTap,
              child: Icon(icon, color: Colors.white),
            ),
          ),
        );
  }
}

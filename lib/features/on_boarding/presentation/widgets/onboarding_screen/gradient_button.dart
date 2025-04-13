import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme_bloc/theme_bloc.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.gradientColors,
    required this.title,
    this.onTap,
  });
  final List<Color> gradientColors;
  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      splashColor: const Color(0xB01565C0),
      highlightColor: const Color(0xB01565C0),
      onTap: onTap,
      child: Ink(
        width: 345,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 12,
                offset: Offset(0, 4),
                color: Color(0x0F000000))
          ],
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: context.read<ThemeBloc>().darkTheme
                  ? const Color(0xFF292929)
                  : const Color(0xFFFFFFFF),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

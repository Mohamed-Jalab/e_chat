import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme_bloc/theme_bloc.dart';

class ResendCode extends StatefulWidget {
  const ResendCode({super.key});

  @override
  State<ResendCode> createState() => _ResendCodeState();
}

class _ResendCodeState extends State<ResendCode> {
  int seconds = 60;
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    seconds = 60;
    while (seconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      seconds--;
      //? I put if(mounted) because setState() after dispose() or after terminat the widget
      //? will throw exception
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 200,
        child: Row(
          children: [
            Icon(
              Icons.access_time_rounded,
              size: 20,
              color: context.read<ThemeBloc>().darkTheme
                  ? const Color(0xFFF0F0F3)
                  : const Color(0xFF2C2D3A),
            ),
            const SizedBox(width: 7),
            Text(
              seconds > 10 ? '00 : $seconds' : '00 : 0$seconds',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.read<ThemeBloc>().darkTheme
                    ? const Color(0xFFF0F0F3)
                    : const Color(0xFF2C2D3A),
              ),
            ),
            const SizedBox(width: 5),
            const Spacer(),
            TextButton(
              onPressed: seconds > 0
                  ? null
                  : () async {
                      init();
                    },
              style: TextButton.styleFrom(
                disabledForegroundColor: (context.read<ThemeBloc>().darkTheme
                        ? const Color(0xFFD0D1DB)
                        : const Color(0xFF1B526B))
                    .withOpacity(.4),
                padding: const EdgeInsets.symmetric(horizontal: 3),
                visualDensity:
                    const VisualDensity(horizontal: -4, vertical: -4),
                foregroundColor: context.read<ThemeBloc>().darkTheme
                    ? const Color(0xFFD0D1DB)
                    : const Color(0xFF1B526B),
                textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0,
                    decoration: TextDecoration.underline),
              ),
              child: const Text('Resend Code'),
            )
          ],
        ));
  }
}

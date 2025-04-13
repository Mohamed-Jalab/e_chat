import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.white,

      /// this [primary] and [secondary] for [Gradient] of [Container]
      primary: const Color(0xFF1bb2f6),
      secondary: const Color(0xFF05aaf4),

      /// for [ContainerClipper] in [LoginScreen]
      secondaryContainer: const Color(0xFFeCF9FF),
    ),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      /// theme of the title in [SplashScreen]
      displayLarge: TextStyle(
          fontSize: 35,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
          color: Color(0xFF0F4888)),

      /// theme of the large title in [LoginScreen]
      titleLarge: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w700,
        color: Color(0xFFFFFFFF),
        letterSpacing: .05,
      ),

      /// theme of the second large title in [LoginScreen]
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
        letterSpacing: .05,
        color: Colors.white,
      ),

      /// theme of the label of TextField [PhoneVerification] in [LoginScreen]
      bodyMedium: TextStyle(
        color: Color(0xFF1B526B),
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ));
final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,

      seedColor: const Color(0xFF292929),

      /// this [primary] and [secondary] for [Gradient] of [Container]
      primary: const Color(0xFF092a51),
      secondary: const Color(0xFF092a51),

      /// for [ContainerClipper] in [LoginScreen]
      secondaryContainer: const Color(0xFF2c2d3a),
    ),
    scaffoldBackgroundColor: const Color(0xFF292929),
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      /// theme of the title in [SplashScreen]
      displayLarge: TextStyle(
          fontSize: 35,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
          color: Color(0xFFFFFFFF)),

      /// theme of the large title in [LoginScreen]
      titleLarge: TextStyle(
        fontSize: 35,
        fontWeight: FontWeight.w700,
        color: Color(0xFF40C4FF),
        letterSpacing: .05,
      ),

      /// theme of the second large title in [LoginScreen]
      titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
        letterSpacing: .05,
        color: Color(0xFF40C4FF),
      ),

      /// theme of the label of TextField [PhoneVerification] in [LoginScreen]
      bodyMedium: TextStyle(
        color: Color(0xFFECF9FF),
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ));

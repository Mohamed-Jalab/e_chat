import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants.dart';
import 'core/theme.dart';
import 'core/theme_bloc/theme_bloc.dart';
import 'features/on_boarding/presentation/screens/splash_screen.dart';
import 'injection.dart' as di;
import 'injection.dart';

bool isDark = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Supabase.initialize(
    url: 'https://kinzxtkspyuhjysojkxl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtpbnp4dGtzcHl1aGp5c29qa3hsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjcxNzQyNTUsImV4cCI6MjA0Mjc1MDI1NX0.ZUfsNQYeMO55SD4qpZIEsgW2uOolRmi3hgsMkM1OALw',
  );
  //* to hide the keyboard if it was opening
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  User? user = Supabase.instance.client.auth.currentUser;
  Session? session = Supabase.instance.client.auth.currentSession;
  print(session?.accessToken);
  print(user?.phone);
  print(user?.phoneConfirmedAt);
  // di.sl<SharedPreferences>().remove(Constants.isDarkMode);
  // di.sl<SharedPreferences>().remove(Constants.isOnboardVisited);
  // di.sl<SharedPreferences>().remove(Constants.isRemembered);
  isDark = di.sl<SharedPreferences>().getBool(Constants.isDarkMode) ?? false;
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => BlocProvider(
      create: (context) => ThemeBloc()..add(GetThemeStorage()),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override

  Widget build(BuildContext context) {
    print("===main.dart===");
    print(isDark);
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          // themeMode: context.read<ThemeBloc>().darkTheme? ThemeMode.dark : ThemeMode.light,

          /// I make this condition to show the dark theme immediately
          /// not switching from light theme to dark theme quickly
          themeMode: state is MainInitial
              ? (isDark ? ThemeMode.dark : ThemeMode.light)
              : (context.read<ThemeBloc>().darkTheme
                  ? ThemeMode.dark
                  : ThemeMode.light),
          title: 'E-Chat',
          home:
              // const TestWidget(),
              const SplashScreen(),
        );
      },
    );
  }
}

class TestWidget extends StatefulWidget {
  const TestWidget({super.key});

  @override
  State<TestWidget> createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: IconButton(
                icon: const Icon(Icons.abc),
                onPressed: () {
                  context.read<ThemeBloc>().add(ChangeThemeEvent(
                      darkTheme: !context.read<ThemeBloc>().darkTheme));
                })));
  }
}

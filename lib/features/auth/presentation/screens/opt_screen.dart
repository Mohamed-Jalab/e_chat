import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants.dart';
import '../../../../injection.dart' as di;
import '../../../on_boarding/presentation/screens/splash_screen.dart';

class OptScreen extends StatelessWidget {
  const OptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            child: const Text("Reset"),
            onPressed: () async {
              await Supabase.instance.client.auth.signOut();
              await di
                  .sl<SharedPreferences>()
                  .setBool(Constants.isOnboardVisited, false);
              await di
                  .sl<SharedPreferences>()
                  .setBool(Constants.isRemembered, false);
              print("Done");
              if (context.mounted) {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SplashScreen()));
              }
            }),
        const SizedBox(height: 10),
        const Text("Get it ."),
      ],
    )));
  }
}

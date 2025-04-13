import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants.dart';
import '../../../../core/routes.dart';
import '../../../../core/theme_bloc/theme_bloc.dart';
import '../../../../injection.dart' as di;
import '../../../auth/presentation/screens/login_screen.dart';
import '../bloc/onboarding_bloc/onboarding_bloc.dart';
import '../widgets/onboarding_screen/clippers/bottom_circle_clipper.dart';
import '../widgets/onboarding_screen/gradient_button.dart';
import '../widgets/onboarding_screen/starter_page_view.dart';
import '../widgets/onboarding_screen/tracking_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("===onboarding_screen.dart===");

    final Size size = MediaQuery.sizeOf(context);
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(),
      child: Scaffold(
        backgroundColor: context.read<ThemeBloc>().darkTheme
            ? const Color(0xFF092A51)
            : const Color(0xFFC4EDFF),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: BottomCircleClipper(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: size.height * .66,
                  width: size.width,
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              ClipPath(
                clipper: BottomCircleClipper(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  alignment: Alignment.center,
                  height: size.height * .59,
                  width: size.width,
                  color: context.read<ThemeBloc>().darkTheme
                      ? const Color(0xFF292929)
                      : const Color(0xFFFFFFFF),
                  child: const StarterPageView(),
                ),
              ),
              Positioned(
                bottom: 0,
                child: SizedBox(
                  height: size.height * .355,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        const Spacer(flex: 13),
                        GradientButton(
                          gradientColors: const [
                            Color(0xFF40C4FF),
                            Color(0xFF03A9F4),
                          ],
                          title: 'Get Started',
                          onTap: () async {
                            await di
                                .sl<SharedPreferences>()
                                .setBool(Constants.isOnboardVisited, true);
                            if (context.mounted) {
                              Navigator.pushReplacement(
                                  context,
                                  SildRightPageRouteWithCustomAnimation(
                                      page: const LoginScreen()));
                            }
                          },
                        ),
                        const Spacer(flex: 13),
                        const TrackingWidget(),
                        const Spacer(flex: 9),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

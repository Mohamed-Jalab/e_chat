import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/routes.dart';
import '../../../../../injection.dart' as di;
import '../../../../auth/presentation/screens/login_screen.dart';
import '../../bloc/onboarding_bloc/onboarding_bloc.dart';
import 'custom_text_button.dart';

class TrackingWidget extends StatelessWidget {
  const TrackingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        OnboardingBloc bloc = BlocProvider.of(context);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextButton(
              title: 'Skip',
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
            SmoothPageIndicator(
              controller: bloc.pageViewController,
              count: Constants.pageViewData.length,
              effect: const SlideEffect(
                dotColor: Color(0xFF7FD7FF),
                activeDotColor: Color(0xFF40C4FF),
                dotWidth: 10,
                dotHeight: 10,
              ),
            ),
            CustomTextButton(
              backgroundColor: const Color(0xFFA7E4FF),
              foregroundColor: const Color(0xFF1B526B),
              title: 'Next',
              onTap: () async {
                if (bloc.pageViewController.page! < 3) {
                  bloc.add(const ChangePageIndicatorEvent());
                } else {
                  await di
                      .sl<SharedPreferences>()
                      .setBool(Constants.isOnboardVisited, true);
                  if (context.mounted) {
                    Navigator.pushReplacement(
                        context,
                        SildRightPageRouteWithCustomAnimation(
                            page: const LoginScreen()));
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}

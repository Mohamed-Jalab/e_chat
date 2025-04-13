import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants.dart';
import '../../../../../core/theme_bloc/theme_bloc.dart';
import '../../bloc/onboarding_bloc/onboarding_bloc.dart';

class StarterPageView extends StatelessWidget {
  const StarterPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        OnboardingBloc bloc = BlocProvider.of(context);
        return SizedBox(
          height: size.height * .492,
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
            controller: bloc.pageViewController,
            itemCount: 4,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  Image(image: AssetImage(Constants.pageViewData[index].image)),
                  const Spacer(flex: 2),
                  Text(
                    Constants.pageViewData[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        letterSpacing: 0.05,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: context.read<ThemeBloc>().darkTheme
                            ? const Color(0xFF40C4FF)
                            : const Color(0xFF1565C0)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    Constants.pageViewData[index].subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: context.read<ThemeBloc>().darkTheme
                            ? const Color(0xFF40C4FF)
                            : const Color(0xFF1565C0)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

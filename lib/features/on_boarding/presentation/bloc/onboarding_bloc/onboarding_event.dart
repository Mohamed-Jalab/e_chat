part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingEvent {
  const OnboardingEvent();
}

class ChangePageIndicatorEvent extends OnboardingEvent {
  const ChangePageIndicatorEvent();
}

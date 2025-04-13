import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PageController pageViewController = PageController();
  OnboardingBloc() : super(OnboardingInitial()) {
    on<ChangePageIndicatorEvent>((event, emit) {
      pageViewController.animateToPage(
        (pageViewController.page?.round() ?? 0) + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(ChangePageIndicatorState());
    });
  }
}

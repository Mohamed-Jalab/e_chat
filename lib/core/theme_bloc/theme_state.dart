part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class MainInitial extends ThemeState {}

class ChangeTheme extends ThemeState {}

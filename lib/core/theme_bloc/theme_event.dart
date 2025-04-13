part of 'theme_bloc.dart';

sealed class ThemeEvent {}

class GetThemeStorage extends ThemeEvent {}

class ChangeThemeEvent extends ThemeEvent {
  final bool darkTheme;

  ChangeThemeEvent({required this.darkTheme});
}

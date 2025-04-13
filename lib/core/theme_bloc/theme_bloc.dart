import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection.dart' as di;
import '../constants.dart';


part 'theme_event.dart';
part 'theme_state.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  bool darkTheme = false;
  ThemeBloc() : super(MainInitial()) {
    on<GetThemeStorage>((event, emit) {
      darkTheme =
          di.sl<SharedPreferences>().getBool(Constants.isDarkMode) ?? false;
      emit(MainInitial());
    });
    on<ChangeThemeEvent>((event, emit) async {
      darkTheme = event.darkTheme;
      await di.sl<SharedPreferences>().setBool(Constants.isDarkMode, darkTheme);
      emit(ChangeTheme());
    });
  }
}

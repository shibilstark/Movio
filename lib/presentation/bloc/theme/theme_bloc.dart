import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movio/config/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(const ThemeState(isDarkMode: false, isFirstLaunch: false)) {
    on<LoadTheme>(_loadTheme);
    on<ChangeTheme>(_changeTheme);
    on<MarkAsFirstLaunched>(_markAsFirstLaunched);
  }

  void _loadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeState(
      isDarkMode: await _getValue(PreferenceKeys.isDarkMode),
      isFirstLaunch: await _getValue(PreferenceKeys.isFirstLuanch),
    ));
  }

  void _changeTheme(ChangeTheme event, Emitter<ThemeState> emit) async {
    await _setValue(PreferenceKeys.isDarkMode, event.isDarkMode);

    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  void _markAsFirstLaunched(
      MarkAsFirstLaunched event, Emitter<ThemeState> emit) async {
    await _setValue(PreferenceKeys.isFirstLuanch, true);

    emit(state.copyWith(isFirstLaunch: true));
  }

  Future<bool> _getValue(String key) async {
    return (await SharedPreferences.getInstance()).getBool(key) ?? false;
  }

  Future<void> _setValue(String key, bool value) async {
    (await SharedPreferences.getInstance()).setBool(key, value);
    return;
  }
}

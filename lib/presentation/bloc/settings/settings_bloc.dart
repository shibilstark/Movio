import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movio/config/constants.dart';
import 'package:movio/global/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<ChangeNSFWStatus>(_changeNsfwStatus);
    on<LoadSettings>(_laodSettings);
  }

  Future _laodSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    UserData.nsfwContentStatus = await _getValue(PreferenceKeys.nsfwStatuc);
    emit(SettingsSuccess(nsfwStatus: UserData.nsfwContentStatus));
  }

  void _changeNsfwStatus(
      ChangeNSFWStatus event, Emitter<SettingsState> emit) async {
    final currentState = state;

    if (currentState is SettingsSuccess) {
      await _setValue(PreferenceKeys.nsfwStatuc, event.value);
      UserData.nsfwContentStatus = event.value;

      emit(currentState.copyWith(nsfwStatus: event.value));
    } else {
      await _laodSettings(const LoadSettings(), emit);
      _changeNsfwStatus(event, emit);
    }
  }

  Future<bool> _getValue(String key) async {
    return (await SharedPreferences.getInstance()).getBool(key) ?? false;
  }

  Future<void> _setValue(String key, bool value) async {
    (await SharedPreferences.getInstance()).setBool(key, value);
    return;
  }
}

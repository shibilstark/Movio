part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class LoadSettings extends SettingsEvent {
  const LoadSettings();

  @override
  List<Object> get props => [];
}

class ChangeNSFWStatus extends SettingsEvent {
  final bool value;
  const ChangeNSFWStatus(this.value);

  @override
  List<Object> get props => [value];
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsSuccess extends SettingsState {
  final bool nsfwStatus;

  const SettingsSuccess({required this.nsfwStatus});
  @override
  List<Object> get props => [nsfwStatus];

  SettingsSuccess copyWith({
    bool? nsfwStatus,
  }) {
    return SettingsSuccess(
      nsfwStatus: nsfwStatus ?? this.nsfwStatus,
    );
  }
}

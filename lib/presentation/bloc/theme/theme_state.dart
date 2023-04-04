// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkMode;
  final bool isFirstLaunch;
  const ThemeState({
    required this.isDarkMode,
    required this.isFirstLaunch,
  });

  @override
  List<Object> get props => [isDarkMode, isFirstLaunch];

  ThemeState copyWith({
    bool? isDarkMode,
    bool? isFirstLaunch,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isFirstLaunch: isFirstLaunch ?? this.isFirstLaunch,
    );
  }
}

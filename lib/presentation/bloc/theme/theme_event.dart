part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();

  @override
  List<Object> get props => [];
}

class ChangeTheme extends ThemeEvent {
  final bool isDarkMode;
  const ChangeTheme(
    this.isDarkMode,
  );

  @override
  List<Object> get props => [isDarkMode];
}

class MarkAsFirstLaunched extends ThemeEvent {
  const MarkAsFirstLaunched();

  @override
  List<Object> get props => [];
}

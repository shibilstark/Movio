import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movio/presentation/bloc/theme/theme_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return FlutterSwitch(
          value: state.isDarkMode,
          onToggle: (val) {
            context.read<ThemeBloc>().add(ChangeTheme(val));
          },
        );
      },
    );
  }
}

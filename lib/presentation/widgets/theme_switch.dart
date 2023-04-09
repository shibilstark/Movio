import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/presentation/bloc/theme/theme_bloc.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key, this.size = 20});
  final double size;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return FlutterSwitch(
          height: size,
          width: size * 1.8,
          padding: size / 7,
          toggleSize: size / 1.5,
          value: state.isDarkMode,
          activeColor: AppColors.orange.withOpacity(0.8),
          inactiveColor: AppColors.white,
          inactiveToggleColor: AppColors.orange.withOpacity(0.8),
          activeToggleColor: AppColors.lightWhite,
          onToggle: (val) {
            context.read<ThemeBloc>().add(ChangeTheme(val));
          },
        );
      },
    );
  }
}

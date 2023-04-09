import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:movio/config/colors.dart';

class CustomSwitchWidget extends StatelessWidget {
  const CustomSwitchWidget({
    super.key,
    this.size = 20,
    required this.onTap,
    required this.currentValue,
  });
  final double size;
  final void Function(bool value) onTap;
  final bool currentValue;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      height: size,
      width: size * 1.8,
      padding: size / 7,
      toggleSize: size / 1.5,
      value: currentValue,
      activeColor: AppColors.orange.withOpacity(0.8),
      inactiveColor: AppColors.white,
      inactiveToggleColor: AppColors.orange.withOpacity(0.8),
      activeToggleColor: AppColors.lightWhite,
      onToggle: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/widgets/theme_switch.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.showThemeSwitch = false,
  });
  final bool showThemeSwitch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      actions: !showThemeSwitch
          ? null
          : const [
              ThemeSwitch(),
            ],
      title: Text(
        AppString.appName.toUpperCase(),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: AppFontWeight.bold,
              color: AppColors.orange,
              letterSpacing: 4,
            ),
      ),
    );
  }
}

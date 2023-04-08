import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/presentation/router/routers.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      titleSpacing: -5.w,
      title: title == null
          ? null
          : Text(
              title!,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: AppFontSize.titleMedium,
                  ),
            ),
      leading: IconButton(
          icon: Icon(
            AppIconAssets.back,
            size: 20,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () {
            AppNavigator.pop(context);
          }),
    );
  }
}

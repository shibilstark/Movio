import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/colors.dart';
import '../../config/dimensions.dart';
import 'gap.dart';

class IconWithText extends StatelessWidget {
  const IconWithText({
    super.key,
    required this.icon,
    required this.label,
    required this.onatp,
    this.iconSize = 20,
  });
  final IconData icon;
  final String label;
  final void Function() onatp;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onatp,
      child: SizedBox(
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.orange,
              size: iconSize,
            ),
            Gap(H: 5.h),
            Text(
              label,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: AppFontSize.displayLarge,
                    fontWeight: AppFontWeight.medium,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

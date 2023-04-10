import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/presentation/widgets/gap.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    required this.error,
    required this.callBack,
  });
  final AppFailure error;
  final void Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getErrorTitleByType(error.type),
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: AppFontWeight.bold,
                  fontSize: AppFontSize.bodyLarge,
                  color: AppColors.orange,
                  letterSpacing: 1.3,
                ),
          ),
          Gap(H: 10.h),
          Text(
            error.message,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: AppFontWeight.regular,
                  fontSize: AppFontSize.displayLarge,
                  color: Theme.of(context).colorScheme.onBackground,
                  letterSpacing: 1.3,
                ),
          ),
          Gap(H: 10.h),
          InkWell(
            onTap: callBack,
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    AppIconAssets.retry,
                    size: 17.w,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  Gap(W: 10.w),
                  Text(
                    AppString.retry,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          fontSize: AppFontSize.displayLarge,
                          fontWeight: AppFontWeight.regular,
                          letterSpacing: 1.5,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String _getErrorTitleByType(AppFailureType type) {
    switch (type) {
      case AppFailureType.client:
        return AppString.titleClientError;
      case AppFailureType.internet:
        return AppString.titleInternetError;
      case AppFailureType.server:
        return AppString.titleServerError;
      default:
        return AppString.titleCommontError;
    }
  }
}

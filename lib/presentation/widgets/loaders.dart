import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/presentation/bloc/theme/theme_bloc.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {Key? key,
      this.isRound = false,
      this.height = 0,
      this.width = 0,
      this.radius = 10})
      : super(key: key);

  final bool isRound;
  final double radius;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Shimmer.fromColors(
            enabled: true,
            period: const Duration(seconds: 2),
            baseColor:
                state.isDarkMode ? AppColors.lightBlack : AppColors.lightWhite,
            highlightColor: state.isDarkMode
                ? AppColors.white.withOpacity(0.2)
                : AppColors.white.withOpacity(0.5),
            child: isRound
                ? CircleAvatar(
                    backgroundColor: AppColors.white,
                    radius: radius,
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.background,
                        borderRadius: BorderRadius.circular(radius)),
                    height: height,
                    width: width,
                  ));
      },
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/presentation/bloc/theme/theme_bloc.dart';

class AppPlaceHolder extends StatelessWidget {
  const AppPlaceHolder({
    Key? key,
    required this.height,
    required this.width,
    this.radius = 10,
  }) : super(key: key);
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: state.isDarkMode
                  ? AppColors.lightBlack
                  : AppColors.lightWhite,
            ),
          ),
        );
      },
    );
  }
}

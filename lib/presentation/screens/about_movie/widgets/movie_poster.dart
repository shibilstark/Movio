import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/paths.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/loaders.dart';
import 'package:movio/presentation/widgets/network_image.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

import '../../../../config/colors.dart';
import '../../../bloc/theme/theme_bloc.dart';

class MoviePosterWidget extends StatelessWidget {
  const MoviePosterWidget({
    super.key,
    required this.movieDetails,
  });

  final MovieDetails movieDetails;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backdropHeight = size.height * 0.25;
    final posterWidth = size.width * 0.25;
    final posterHeight = posterWidth * 1.5;
    return SizedBox(
      height: backdropHeight + (posterHeight / 2),
      child: Stack(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: backdropHeight,
                child: NetWorkImageWidget(
                  image: ApiPaths.image(movieDetails.backdropPath),
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                width: double.infinity,
                height: backdropHeight,
                color: AppColors.black.withOpacity(0.2),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RoundedContainerWidget(
                    borderRadius: BorderRadius.circular(5),
                    height: posterHeight,
                    width: posterWidth,
                    child: NetWorkImageWidget(
                      image: ApiPaths.image(movieDetails.posterPath),
                    ),
                  ),
                  Gap(W: 15.w),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          movieDetails.title,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: AppFontSize.titleMedium,
                                    fontWeight: AppFontWeight.semiBold,
                                  ),
                        ),
                        Gap(H: 5.h),
                        Builder(builder: (context) {
                          final genreText = movieDetails.genres
                              .where((element) => element.name != null)
                              .toList()
                              .map((e) => e.name!.toUpperCase())
                              .toList()
                              .join(" | ");
                          return Text(
                            genreText,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  fontSize: AppFontSize.displayLarge,
                                  fontWeight: AppFontWeight.medium,
                                ),
                            overflow: TextOverflow.clip,
                          );
                        }),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MoviePosterLoadingWidget extends StatelessWidget {
  const MoviePosterLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backdropHeight = size.height * 0.25;
    final posterWidth = size.width * 0.25;
    final posterHeight = posterWidth * 1.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: backdropHeight + (posterHeight / 2),
          child: Stack(
            children: [
              Container(
                height: backdropHeight,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocBuilder<ThemeBloc, ThemeState>(
                        builder: (context, state) {
                          return Container(
                            height: posterHeight,
                            width: posterWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 3,
                                    spreadRadius: 5,
                                    color: state.isDarkMode
                                        ? AppColors.lightWhite.withOpacity(0.07)
                                        : AppColors.lightBlack.withOpacity(0.1),
                                    offset: const Offset(2, 2))
                              ],
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          );
                        },
                      ),
                      Gap(W: 15.w),
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ShimmerWidget(
                              height: 20.h,
                              width: 100.w,
                              radius: 3,
                            ),
                            Gap(H: 5.h),
                            ShimmerWidget(
                              height: 10.h,
                              width: double.infinity,
                              radius: 3,
                            ),
                            Gap(H: 5.h),
                            ShimmerWidget(
                              height: 10.h,
                              width: 80.w,
                              radius: 3,
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Gap(H: 20.h),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => ShimmerWidget(
                  height: 15.h,
                  width: double.infinity,
                  radius: 3,
                ),
            separatorBuilder: (context, index) => Gap(H: 5.h),
            itemCount: 6)
      ],
    );
  }
}

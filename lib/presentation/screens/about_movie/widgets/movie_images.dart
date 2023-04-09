import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/paths.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
import 'package:movio/domain/movies/models/movie_image.dart';
import 'package:movio/presentation/router/routers.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/network_image.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

import '../../../bloc/more_movies/more_movies_bloc.dart';

class MovieImagesWidget extends StatelessWidget {
  const MovieImagesWidget({
    super.key,
    required this.datas,
  });

  final dynamic datas;

  @override
  Widget build(BuildContext context) {
    if (datas is MovieImage) {
      final movieImages = datas as MovieImage;
      final postersToShowHere = movieImages.posters.take(10).toList();
      final backdropsToShowHere = movieImages.backdrops.take(10).toList();
      return Column(
        children: [
          GridView.builder(
            itemCount: postersToShowHere.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => RoundedContainerWidget(
              borderRadius: BorderRadius.circular(5),
              child: NetWorkImageWidget(
                image:
                    ApiPaths.originalImage(postersToShowHere[index].filePath),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
          ),
          Gap(H: 20.h),
          GridView.builder(
            itemCount: backdropsToShowHere.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => RoundedContainerWidget(
              borderRadius: BorderRadius.circular(5),
              child: NetWorkImageWidget(
                image:
                    ApiPaths.originalImage(backdropsToShowHere[index].filePath),
              ),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4 / 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
          ),
        ],
      );
    }

    if (datas is AppFailure) {
      return const Gap();
    }

    return GridView.builder(
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => RoundedContainerWidget(
        borderRadius: BorderRadius.circular(5),
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
    );
  }
}

class MovieAdditionalDetailWidget extends StatelessWidget {
  const MovieAdditionalDetailWidget({
    super.key,
    required this.movie,
  });

  final MovieDetails movie;

  @override
  Widget build(BuildContext context) {
    const titleList = [
      AppString.releaseData,
      AppString.budget,
      AppString.revenue,
      AppString.originalLanguage,
      AppString.popularity,
    ];
    final valueList = [
      DateFormat("dd  MMMM, yyyy").format(
        DateTime.parse(movie.releaseDate),
      ),
      MoneyFormatter(amount: movie.budget.toDouble())
          .output
          .compactSymbolOnLeft,
      MoneyFormatter(amount: movie.revenue.toDouble())
          .output
          .compactSymbolOnLeft,
      movie.originalLanguage,
      "${movie.popularity.ceil()} pts",
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              movie.isAdult
                  ? LimitedBox(
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.orange,
                            child: Text(
                              AppString.adultSymbol,
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: AppFontWeight.semiBold,
                                fontSize: AppFontSize.displayLarge,
                              ),
                            ),
                          ),
                          Gap(W: 10.w),
                        ],
                      ),
                    )
                  : const Gap(),
              RoundedContainerWidget(
                borderRadius: BorderRadius.circular(5),
                decoration: BoxDecoration(
                  color: AppColors.orange.withOpacity(0.5),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                  child: Text(
                    movie.status,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: AppFontWeight.semiBold,
                          fontSize: AppFontSize.bodyMedium,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Gap(H: 10.h),
          Text(
            movie.overview,
            style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: AppFontSize.bodySmall,
                  fontWeight: AppFontWeight.medium,
                ),
            overflow: TextOverflow.clip,
          ),
          Gap(H: 10.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => MovieDetailTileWidget(
              title: titleList[index],
              value: valueList[index],
            ),
            separatorBuilder: (context, index) => Gap(H: 10.h),
            itemCount: titleList.length,
          ),
          Gap(H: 10.h),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    context
                        .read<MoreMoviesBloc>()
                        .add(GetSimilarMovies(movie.id));
                    AppNavigator.push(
                      context: context,
                      screenName: AppRouter.MORE_MOVIE_BY_TYPE,
                    );
                  },
                  color: AppColors.orange,
                  child: Text(
                    AppString.moreSimilarMovies,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: AppFontWeight.semiBold,
                          fontSize: AppFontSize.bodyMedium,
                          color: AppColors.white,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MovieDetailTileWidget extends StatelessWidget {
  const MovieDetailTileWidget({
    super.key,
    required this.title,
    required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title :",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: AppFontSize.bodySmall,
                fontWeight: AppFontWeight.bold,
              ),
        ),
        Gap(W: 5.w),
        Text(
          value,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: AppFontSize.bodySmall,
                fontWeight: AppFontWeight.semiBold,
              ),
        ),
      ],
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/loaders.dart';
import 'package:movio/presentation/widgets/movie_poster.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

import '../bloc/home/home_bloc.dart';
import '../bloc/movie_detail/movie_detail_bloc.dart';
import '../router/routers.dart';

class CollectionRowWidget extends StatelessWidget {
  const CollectionRowWidget({
    super.key,
    required this.collection,
    required this.type,
  });
  final MovieCollectionType type;
  final Either<MovieCollection, AppFailure>? collection;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.25;
    final height = width * 1.5;

    if (collection == null) {
      return const CollectionRowLoadingWidget();
    }

    return collection!.fold((movieCollection) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppString.getCollectionNameByType(type),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: AppFontSize.bodyMedium,
                  fontWeight: AppFontWeight.bold,
                  letterSpacing: 1.5,
                ),
          ),
          Gap(H: 10.h),
          SizedBox(
            height: height,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gap(W: 5.w),
                itemCount: movieCollection.movies.length,
                itemBuilder: (context, index) {
                  final movie = movieCollection.movies[index];
                  return InkWell(
                    onTap: () {
                      context
                          .read<MovieDetailBloc>()
                          .add(LoadMovieDetails(movie.id));

                      AppNavigator.push(
                          context: context, screenName: AppRouter.ABOUT_MOVIE);
                    },
                    child: MoviePosterWidget(
                      height: height,
                      width: width,
                      poster: movie.posterPath,
                    ),
                  );
                }),
          ),
        ],
      );
    }, (error) {
      return CollectionRowErrorWidget(
        type: type,
        message: error.message,
      );
    });
  }
}

class TopTenCollectionRowWidget extends StatelessWidget {
  const TopTenCollectionRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.25;
    final height = width * 1.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Trending",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: AppFontSize.bodyMedium,
                fontWeight: AppFontWeight.bold,
                letterSpacing: 1.5,
              ),
        ),
        Gap(H: 10.h),
        SizedBox(
          height: height,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Gap(W: 5.w),
              itemCount: 10,
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          key: UniqueKey(),
                          height: height,
                          width: width,
                          decoration: BoxDecoration(
                            color: Colors.accents[index],
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: RoundedContainerWidget(
                              height: height / 6,
                              width: width / 4,
                              borderRadius: BorderRadius.circular(5),
                              decoration: BoxDecoration(
                                color: AppColors.black,
                              ),
                              child: Text(
                                "#$index",
                                style: TextStyle(color: AppColors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
        ),
      ],
    );
  }
}

class CollectionRowLoadingWidget extends StatelessWidget {
  const CollectionRowLoadingWidget({
    super.key,
    this.label,
  });

  final String? label;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.25;
    final height = width * 1.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Text(
                label!,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.bold,
                      letterSpacing: 1.5,
                    ),
              )
            : ShimmerWidget(
                height: 16.h,
                width: 100.w,
                radius: 3,
              ),
        Gap(H: 10.h),
        SizedBox(
            height: height,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gap(W: 5.w),
                itemCount: 10,
                itemBuilder: (context, index) => ShimmerWidget(
                      height: height,
                      width: width,
                      radius: 10,
                    ))),
      ],
    );
  }
}

class CollectionRowErrorWidget extends StatelessWidget {
  const CollectionRowErrorWidget({
    super.key,
    required this.type,
    required this.message,
  });
  final MovieCollectionType type;
  final String message;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.25;
    final height = width * 1.5;

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0.5,
          child: CollectionRowLoadingWidget(
            label: AppString.getCollectionNameByType(type),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                message,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: AppFontSize.bodyMedium,
                      fontWeight: AppFontWeight.regular,
                      letterSpacing: 1.5,
                    ),
              ),
              Gap(H: 10.h),
              InkWell(
                onTap: () {
                  context.read<HomeBloc>().add(ReloadSingleCollection(type));
                },
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(AppIconAssets.retry, size: 20.w),
                      Gap(W: 10.w),
                      Text(
                        AppString.retry,
                        style:
                            Theme.of(context).textTheme.displayLarge!.copyWith(
                                  fontSize: AppFontSize.bodyMedium,
                                  fontWeight: AppFontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/paths.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/presentation/router/routers.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/icon_with_text.dart';
import 'package:movio/presentation/widgets/loaders.dart';
import 'package:movio/presentation/widgets/network_image.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

import '../../../bloc/home/home_bloc.dart';
import '../../../bloc/movie_detail/movie_detail_bloc.dart';

class TrendingCarouselWidget extends StatelessWidget {
  const TrendingCarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          try {
            final trending = state.allCollections.firstWhere(
                (element) => element.type == MovieCollectionType.trending);

            if (trending.collection == null) {
              return HomeCarouselLoadingWidget(
                width: width,
              );
            }

            if (trending.collection is MovieCollection) {
              final collection = trending.collection as MovieCollection;

              return HomeCarouselViewWidget(
                width: width,
                movies: collection.movies,
              );
            }

            return const SizedBox();
          } catch (e) {
            return HomeCarouselLoadingWidget(
              width: width,
            );
          }
        }

        return HomeCarouselLoadingWidget(
          width: width,
        );
      },
    );
  }
}

class HomeCarouselLoadingWidget extends StatelessWidget {
  const HomeCarouselLoadingWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (context, index, realIndex) {
              return RoundedContainerWidget(
                borderRadius: BorderRadius.circular(15),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).colorScheme.background,
                ),
              );
            },
            options: CarouselOptions(
              viewportFraction: 0.6,
              pageSnapping: true,
              aspectRatio: 220 / 180,
              enlargeFactor: 0.3,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
            ),
          ),
        ),
        Gap(H: 20.h),
        CarouselActionsLoadingWidget(
          width: width,
        )
      ],
    );
  }
}

class HomeCarouselViewWidget extends StatefulWidget {
  const HomeCarouselViewWidget({
    super.key,
    required this.width,
    required this.movies,
  });

  final double width;
  final List<Movie> movies;

  @override
  State<HomeCarouselViewWidget> createState() => _HomeCarouselViewWidgetState();
}

class _HomeCarouselViewWidgetState extends State<HomeCarouselViewWidget> {
  late final ValueNotifier<int> titleController;

  @override
  void initState() {
    titleController = ValueNotifier(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider.builder(
            itemCount: widget.movies.length,
            itemBuilder: (context, index, realIndex) {
              final movie = widget.movies[index];

              return InkWell(
                onTap: () {
                  context
                      .read<MovieDetailBloc>()
                      .add(LoadMovieDetails(movie.id));

                  AppNavigator.push(
                      context: context, screenName: AppRouter.ABOUT_MOVIE);
                },
                child: RoundedContainerWidget(
                  borderRadius: BorderRadius.circular(15),
                  width: widget.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: NetWorkImageWidget(
                    image: ApiPaths.originalImage(movie.posterPath),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                titleController.value = index;
                titleController.notifyListeners();
              },
              viewportFraction: 0.6,
              pageSnapping: true,
              aspectRatio: 220 / 180,
              enlargeFactor: 0.3,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
            ),
          ),
        ),
        Gap(H: 20.h),
        CarouselActionsWidget(
          titleController: titleController,
          movies: widget.movies,
          width: widget.width,
        )
      ],
    );
  }
}

//
//
//
//
//
//
//
//

class CarouselActionsWidget extends StatelessWidget {
  const CarouselActionsWidget({
    super.key,
    required this.titleController,
    required this.movies,
    required this.width,
  });

  final ValueNotifier<int> titleController;
  final List<Movie> movies;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: titleController,
      builder: (context, val, _) {
        final movie = movies[titleController.value];
        final genreText = movie.genreIds
            .where((element) => element.name != null)
            .toList()
            .map((e) => e.name!.toUpperCase())
            .toList()
            .join(" | ");
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: AppFontSize.titleLarge,
                      fontWeight: AppFontWeight.bold,
                    ),
              ),
              Gap(H: 5.h),
              Text(
                genreText,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: AppFontSize.displayLarge,
                      fontWeight: AppFontWeight.medium,
                    ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(H: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                child: Row(
                  children: [
                    IconWithText(
                      icon: AppIconAssets.info,
                      label: AppString.about,
                      onTap: () {
                        context
                            .read<MovieDetailBloc>()
                            .add(LoadMovieDetails(movie.id));

                        AppNavigator.push(
                            context: context,
                            screenName: AppRouter.ABOUT_MOVIE);
                      },
                    ),
                    Gap(W: 15.w),
                    Expanded(
                        child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                      color: Theme.of(context).colorScheme.background,
                      onPressed: () {
                        context
                            .read<MovieDetailBloc>()
                            .add(LoadMovieDetails(movie.id));

                        AppNavigator.push(
                            context: context,
                            screenName: AppRouter.ABOUT_MOVIE);
                      },
                      child: Text(
                        AppString.knowMore,
                        style: TextStyle(
                          fontWeight: AppFontWeight.medium,
                          fontSize: AppFontSize.bodyLarge,
                          color: AppColors.orange,
                          letterSpacing: 3,
                        ),
                      ),
                    )),
                    Gap(W: 15.w),
                    IconWithText(
                      icon: AppIconAssets.bookMark,
                      label: AppString.add,
                      onTap: () {
                        // TODO
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CarouselActionsLoadingWidget extends StatelessWidget {
  const CarouselActionsLoadingWidget({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerWidget(
            height: 25.h,
            width: 150.w,
            radius: 3,
          ),
          Gap(H: 5.h),
          ShimmerWidget(
            height: 10.h,
            width: 100.w,
            radius: 3,
          ),
          Gap(H: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.1),
            child: Row(
              children: [
                const ShimmerWidget(
                  radius: 20,
                  isRound: true,
                ),
                Gap(W: 15.w),
                Expanded(
                  child: ShimmerWidget(
                    height: 40.h,
                    width: 150.w,
                    radius: 10,
                  ),
                ),
                Gap(W: 15.w),
                const ShimmerWidget(
                  radius: 20,
                  isRound: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

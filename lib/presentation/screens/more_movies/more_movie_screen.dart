import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/presentation/bloc/more_movies/more_movies_bloc.dart';
import 'package:movio/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movio/presentation/widgets/gap.dart';

import '../../../config/dimensions.dart';
import '../../../config/paths.dart';
import '../../../config/strings.dart';
import '../../router/routers.dart';
import '../../widgets/common_appbar.dart';
import '../../widgets/network_image.dart';
import '../../widgets/rounded_container.dart';

class MoreMovieScreen extends StatefulWidget {
  const MoreMovieScreen({super.key, this.type, this.movieId = 0});

  final MovieCollectionType? type;
  final int movieId;

  @override
  State<MoreMovieScreen> createState() => _MoreMovieScreenState();
}

class _MoreMovieScreenState extends State<MoreMovieScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    final state = context.read<MoreMoviesBloc>().state;

    var max = scrollController.position.maxScrollExtent;

    if (state is MoreMoviesSuccess &&
        !state.isReloading &&
        scrollController.offset == max) {
      context.read<MoreMoviesBloc>().add(widget.type == null
          ? ReLoadSimilarMovies(widget.movieId)
          : ReLoadCollection(widget.type!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppSpecific.appBarHeight,
        child: CommonAppBar(
          title: widget.type == null
              ? AppString.similarMovies
              : AppString.getCollectionNameByType(widget.type!),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Gap(H: 10.h),
            BlocBuilder<MoreMoviesBloc, MoreMoviesState>(
              builder: (context, state) {
                if (state is MoreMoviesSuccess) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.similarCollection.movies.length + 1,
                    itemBuilder: (context, index) =>
                        index == state.similarCollection.movies.length
                            ? const Gap()
                            : InkWell(
                                onTap: () {
                                  context.read<MovieDetailBloc>().add(
                                      LoadMovieDetails(state
                                          .similarCollection.movies[index].id));

                                  AppNavigator.push(
                                      context: context,
                                      screenName: AppRouter.ABOUT_MOVIE);
                                },
                                child: RoundedContainerWidget(
                                  borderRadius: BorderRadius.circular(5),
                                  child: NetWorkImageWidget(
                                      image: ApiPaths.image(state
                                          .similarCollection
                                          .movies[index]
                                          .posterPath)),
                                ),
                              ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                  );
                }

                if (state is MoreMoviesError) {}

                return GridView.builder(
                  itemCount: 20,
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
              },
            ),
            BlocBuilder<MoreMoviesBloc, MoreMoviesState>(
              builder: (context, state) {
                if (state is MoreMoviesSuccess && state.isReloading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: CircleAvatar(
                      backgroundColor: AppColors.lightWhite,
                      child: Padding(
                        padding: EdgeInsets.all(10.sp),
                        child: CircularProgressIndicator(
                          color: AppColors.orange,
                          strokeWidth: 3,
                        ),
                      ),
                    ),
                  );
                }

                return const Gap();
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/paths.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/bloc/search_idle/search_idle_bloc.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/network_image.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

import '../../../bloc/movie_detail/movie_detail_bloc.dart';
import '../../../router/routers.dart';

class SearchIdleWidget extends StatefulWidget {
  const SearchIdleWidget({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<SearchIdleWidget> createState() => _SearchIdleWidgetState();
}

class _SearchIdleWidgetState extends State<SearchIdleWidget> {
  @override
  void initState() {
    widget.scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    final state = context.read<SearchIdleBloc>().state;

    var max = widget.scrollController.position.maxScrollExtent;

    if (state is SearchIdleSuccess &&
        !state.isReloading &&
        widget.scrollController.offset == max) {
      context.read<SearchIdleBloc>().add(const LoadNewPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      controller: widget.scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppString.trending,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AppFontSize.bodyMedium,
                        fontWeight: AppFontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                ),
                Gap(H: 10.h),
                BlocBuilder<SearchIdleBloc, SearchIdleState>(
                  builder: (context, state) {
                    if (state is SearchIdleSuccess) {
                      return GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.collection.movies.length + 1,
                        itemBuilder: (context, index) => index ==
                                state.collection.movies.length
                            ? const Gap()
                            : InkWell(
                                onTap: () {
                                  context.read<MovieDetailBloc>().add(
                                      LoadMovieDetails(
                                          state.collection.movies[index].id));

                                  AppNavigator.push(
                                      context: context,
                                      screenName: AppRouter.ABOUT_MOVIE);
                                },
                                child: RoundedContainerWidget(
                                  borderRadius: BorderRadius.circular(5),
                                  child: NetWorkImageWidget(
                                      image: ApiPaths.image(state.collection
                                          .movies[index].posterPath)),
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

                    if (state is SearchIdleError) {}

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
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                    );
                  },
                ),
              ],
            ),
            BlocBuilder<SearchIdleBloc, SearchIdleState>(
              builder: (context, state) {
                if (state is SearchIdleSuccess && state.isReloading) {
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

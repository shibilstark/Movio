import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/paths.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/bloc/search_idle/search_idle_bloc.dart';
import 'package:movio/presentation/widgets/error.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/network_image.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

import '../../../bloc/movie_detail/movie_detail_bloc.dart';
import '../../../bloc/movie_search/movie_search_bloc.dart';
import '../../../router/routers.dart';

class SearchResultWidget extends StatefulWidget {
  const SearchResultWidget({
    super.key,
    required this.scrollController,
    required this.searchController,
    required this.focusNode,
  });

  final ScrollController scrollController;
  final ValueNotifier<TextEditingController> searchController;
  final ValueNotifier<FocusNode> focusNode;

  @override
  State<SearchResultWidget> createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
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
    final state = context.read<MovieSearchBloc>().state;

    var max = widget.scrollController.position.maxScrollExtent;

    if (state is MovieSearchSuccess &&
        !state.isReloading &&
        widget.scrollController.offset == max) {
      final query = widget.searchController.value.text.trim();

      if (query.isNotEmpty) {
        context.read<MovieSearchBloc>().add(LoadNewResults(query: query));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.searchController.value.text.trim().isNotEmpty) {
          widget.searchController.value.clear();
          widget.searchController.notifyListeners();
          widget.focusNode.value.unfocus();
          widget.focusNode.notifyListeners();
          return false;
        }
        return true;
      },
      child: SingleChildScrollView(
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
                    AppString.searchResults,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: AppFontSize.bodyMedium,
                          fontWeight: AppFontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                  ),
                  Gap(H: 10.h),
                  BlocBuilder<MovieSearchBloc, MovieSearchState>(
                    builder: (context, state) {
                      if (state is MovieSearchSuccess) {
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
                                        screenName: AppRouter.ABOUT_MOVIE,
                                        arguments: {
                                          "movieId":
                                              state.collection.movies[index].id,
                                        });
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
                            crossAxisCount: 3,
                            childAspectRatio: 2 / 3,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                        );
                      }

                      if (state is MovieSearchError) {
                        return AppErrorWidget(
                            callBack: () {
                              widget.focusNode.value.requestFocus();
                            },
                            error: state.error);
                      }

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
                          crossAxisCount: 3,
                          childAspectRatio: 2 / 3,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                      );
                    },
                  ),
                ],
              ),
              BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state is MovieSearchSuccess && state.isReloading) {
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

                  return Gap();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

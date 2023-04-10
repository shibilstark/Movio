import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/screens/about_movie/widgets/movie_images.dart';
import 'package:movio/presentation/screens/about_movie/widgets/movie_poster.dart';
import 'package:movio/presentation/widgets/common_appbar.dart';
import 'package:movio/presentation/widgets/error.dart';
import 'package:movio/presentation/widgets/gap.dart';

import '../../bloc/movie_detail/movie_detail_bloc.dart';

class AboutMovieScreen extends StatelessWidget {
  const AboutMovieScreen({
    super.key,
    required this.movieId,
  });
  final int movieId;
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PreferredSize(
        preferredSize: AppSpecific.appBarHeight,
        child: CommonAppBar(title: AppString.aboutMovie),
      ),
      body: SafeArea(child: SizedBox(
        child: SingleChildScrollView(
          child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailSuccess) {
                return Column(
                  children: [
                    MoviePosterWidget(movieDetails: state.movie),
                    Gap(H: 20.h),
                    MovieAdditionalDetailWidget(movie: state.movie),
                    Gap(H: 20.h),
                    MovieImagesWidget(datas: state.movieImages),
                  ],
                );
              }

              if (state is MovieDetailError) {
                return AppErrorWidget(
                    callBack: () {
                      context
                          .read<MovieDetailBloc>()
                          .add(LoadMovieDetails(movieId));
                    },
                    error: state.error);
              }

              return Column(
                children: const [
                  MoviePosterLoadingWidget(),
                ],
              );
            },
          ),
        ),
      )),
    );
  }
}

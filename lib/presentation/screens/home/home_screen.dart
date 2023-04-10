import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/presentation/widgets/error.dart';
import 'package:movio/presentation/widgets/movie_collection_row_widget.dart';
import 'package:movio/presentation/screens/home/widgets/trending_carousel.dart';
import 'package:movio/presentation/widgets/gap.dart';

import '../../bloc/home/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return HomeBody(
            scrollController: widget.scrollController,
            collections: state.allCollections,
          );
        } else if (state is HomeError) {
          return AppErrorWidget(
              callBack: () {
                context.read<HomeBloc>().add(const LoadCollections());
              },
              error: state.error);
        } else {
          return const Center(child: SizedBox());
        }
      },
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.scrollController,
    required this.collections,
  });
  final ScrollController scrollController;
  final List<MovieCollectionWithType> collections;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          const TrendingCarouselWidget(),
          Gap(H: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gap(H: 20.h),
                itemCount: MovieCollectionType.values.length,
                itemBuilder: (context, index) {
                  try {
                    final movieCollection = collections.firstWhere((element) =>
                        element.type == MovieCollectionType.values[index]);

                    if (movieCollection.type == MovieCollectionType.trending) {
                      return const Gap();
                    }

                    return CollectionRowWidget(
                      collection: movieCollection.collection,
                      type: MovieCollectionType.values[index],
                    );
                  } catch (e) {
                    return const CollectionRowLoadingWidget();
                  }
                }),
          ),
          Gap(H: 20.h),
        ],
      ),
    );
  }
}

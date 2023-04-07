import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/presentation/screens/home/widgets/movie_collection_row_widget.dart';
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
    context.read<HomeBloc>().add(const LoadCollections());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBody(
      scrollController: widget.scrollController,
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
    required this.scrollController,
  });
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: [
          TrendingCarouselWidget(),
          Gap(H: 20.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) => Gap(H: 10.h),
                itemCount: 4,
                itemBuilder: (context, index) => index % 2 == 0
                    ? CollectionRowWidget()
                    : TopTenCollectionRowWidget()),
          ),
          Gap(H: 20.h),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/presentation/screens/home/widgets/bottom_nav.dart';
import 'package:movio/presentation/screens/home/widgets/home_appbar.dart';
import 'package:movio/presentation/screens/home/widgets/movie_collection_row_widget.dart';
import 'package:movio/presentation/screens/home/widgets/trending_carousel.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/scroll_to_hide.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ValueNotifier<int> bottomNavController;
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    bottomNavController = ValueNotifier<int>(0);
    super.initState();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: const PreferredSize(
          preferredSize: AppSpecific.appBarHeight,
          child: HomeAppBar(
            showThemeSwitch: true,
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            HomeBody(
              scrollController: scrollController,
            ),
            HideOnScroll(
              controller: scrollController,
              visibleHeight: 85.h,
              child: CustomBottomNav(
                bottomNavController: bottomNavController,
              ),
            )
          ],
        ),
      ),
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
          const TrendingCarouselWidget(),
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

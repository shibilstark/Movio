import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/icon_with_text.dart';

class TrendingCarouselWidget extends StatefulWidget {
  const TrendingCarouselWidget({super.key});

  @override
  State<TrendingCarouselWidget> createState() => _TrendingCarouselWidgetState();
}

class _TrendingCarouselWidgetState extends State<TrendingCarouselWidget> {
  late final CarouselController controller;
  late final ValueNotifier<int> titleController;

  @override
  void initState() {
    controller = CarouselController();
    titleController = ValueNotifier(0);
    super.initState();
  }

  final dummyGenres = ["Action", "Drama", "Thriller", "Mystery"];
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.6;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: CarouselSlider.builder(
            itemCount: list2.length,
            itemBuilder: (context, index, realIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.accents[index],
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
        ValueListenableBuilder(
          valueListenable: titleController,
          builder: (context, val, _) {
            final genreText =
                dummyGenres.map((e) => e.toUpperCase()).toList().join(" | ");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Movei Name",
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
                          onatp: () {},
                        ),
                        Gap(W: 15.w),
                        Expanded(
                            child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 0,
                          color: Theme.of(context).colorScheme.background,
                          onPressed: () {},
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
                          onatp: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        )
      ],
    );
  }
}

List list2 = [1, 2, 3, 4, 5, 6];

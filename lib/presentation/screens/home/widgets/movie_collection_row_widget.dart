import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/rounded_container.dart';

class CollectionRowWidget extends StatelessWidget {
  const CollectionRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final list = List.generate(10, (index) => index);
    final width = MediaQuery.of(context).size.width * 0.25;
    final height = width * 1.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Trending",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: AppFontSize.bodyMedium,
                    fontWeight: AppFontWeight.bold,
                    letterSpacing: 1.5,
                  ),
            ),
            InkWell(
              onTap: () {},
              child: SizedBox(
                child: LimitedBox(
                  child: Row(
                    children: [
                      Text(
                        AppString.seeAll,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: AppFontSize.displayLarge,
                              fontWeight: AppFontWeight.regular,
                              letterSpacing: 1.5,
                            ),
                      ),
                      Gap(W: 3.w),
                      const Icon(
                        AppIconAssets.forwardArrow,
                        size: 15,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        Gap(H: 10.h),
        SizedBox(
          height: height,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) => Gap(W: 5.w),
              itemCount: list.length,
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      key: UniqueKey(),
                      height: 100,
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.accents[index],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  )),
        ),
      ],
    );
  }
}

class TopTenCollectionRowWidget extends StatelessWidget {
  const TopTenCollectionRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final list = List.generate(10, (index) => index);
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
              itemCount: list.length,
              itemBuilder: (context, index) => ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      fit: StackFit.passthrough,
                      children: [
                        Container(
                          key: UniqueKey(),
                          height: 100,
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

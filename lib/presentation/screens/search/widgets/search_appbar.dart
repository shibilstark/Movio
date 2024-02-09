// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/utils/date_time/debouncer.dart';

import '../../../widgets/rounded_container.dart';

class SearchAppBarWidget extends StatelessWidget {
  const SearchAppBarWidget({
    super.key,
    required this.focusNotifier,
    required this.searchController,
    required this.debouncer,
  });

  final ValueNotifier<FocusNode> focusNotifier;
  final ValueNotifier<TextEditingController> searchController;
  final Debouncer debouncer;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      titleSpacing: 5,
      title: SizedBox(
        height: 35.h,
        child: Row(
          children: [
            Icon(
              AppIconAssets.search,
              color: AppColors.orange,
              size: 20.sp,
            ),
            Gap(W: 5.w),
            Expanded(
              child: RoundedContainerWidget(
                borderRadius: BorderRadius.circular(5),
                child: TextField(
                  focusNode: focusNotifier.value,
                  onChanged: (value) {
                    debouncer.run(() {
                      if (value.trim().isNotEmpty) {
                        context
                            .read<MovieSearchBloc>()
                            .add(SearchMovie(value.trim()));
                      }

                      focusNotifier.notifyListeners();
                      searchController.notifyListeners();
                    });
                  },
                  textAlignVertical: TextAlignVertical.center,
                  controller: searchController.value,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: AppFontSize.bodyMedium,
                        fontWeight: AppFontWeight.semiBold,
                        letterSpacing: 1.1,
                      ),
                  decoration: InputDecoration(
                    hintText: "Search Movies...",
                    alignLabelWithHint: false,
                    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: AppFontSize.bodyMedium,
                          fontWeight: AppFontWeight.semiBold,
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.8),
                          letterSpacing: 1.1,
                        ),
                    suffixIcon: ValueListenableBuilder(
                        valueListenable: searchController,
                        builder: (context, controller, _) {
                          return InkWell(
                            onTap: () {
                              controller.clear();
                              searchController.notifyListeners();
                            },
                            child: searchController.value.text.trim().isEmpty
                                ? const Gap()
                                : Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                  ),
                          );
                        }),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

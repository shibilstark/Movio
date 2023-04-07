import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movio/config/assets.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';

import '../../../bloc/theme/theme_bloc.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({
    super.key,
    required this.bottomNavController,
  });
  final ValueNotifier<int> bottomNavController;

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppSpecific.bottomNavRadius),
                color: Theme.of(context).appBarTheme.backgroundColor,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 3,
                      color: state.isDarkMode
                          ? AppColors.lightWhite.withOpacity(0.07)
                          : AppColors.lightBlack.withOpacity(0.1),
                      offset: const Offset(0, 0))
                ]),
            child: ValueListenableBuilder(
                valueListenable: widget.bottomNavController,
                builder: (context, val, _) {
                  return ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSpecific.bottomNavRadius),
                    child: BottomNavigationBar(
                      type: BottomNavigationBarType.fixed,
                      currentIndex: val,
                      onTap: (index) {
                        widget.bottomNavController.value = index;
                        widget.bottomNavController.notifyListeners();
                      },
                      selectedIconTheme:
                          Theme.of(context).primaryIconTheme.copyWith(
                                weight: 600,
                              ),
                      unselectedIconTheme:
                          Theme.of(context).primaryIconTheme.copyWith(
                                color: state.isDarkMode
                                    ? AppColors.white.withOpacity(0.6)
                                    : AppColors.black.withOpacity(0.6),
                                weight: 400,
                              ),
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(AppIconAssets.home),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(AppIconAssets.search),
                          label: "Search",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(AppIconAssets.bookMark),
                          label: "BookMarks",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(AppIconAssets.settings),
                          label: "Settings",
                        ),
                      ],
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/presentation/screens/dashboard/appbar.dart';
import 'package:movio/presentation/screens/home/home_screen.dart';
import 'package:movio/presentation/screens/search/search_screen.dart';
import 'package:movio/presentation/screens/settings/settings_screen.dart';
import 'package:movio/presentation/widgets/gap.dart';
import 'package:movio/presentation/widgets/scroll_to_hide.dart';

import 'bottom_nav.dart';

final ValueNotifier<int> bottomNavController = ValueNotifier<int>(0);
final ScrollController glabalScrollController = ScrollController();

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _tabs = [
    HomeScreen(scrollController: glabalScrollController),
    SearchScreen(scrollController: glabalScrollController),
    Container(),
    SettingsScreen(scrollController: glabalScrollController)
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: bottomNavController,
        builder: (context, value, child) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              appBar: PreferredSize(
                preferredSize: value == 1
                    ? const Size.fromHeight(0)
                    : AppSpecific.appBarHeight,
                child: value == 1 ? const Gap() : const CustomAppBar(),
              ),
              body: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  _tabs[value],
                  HideOnScroll(
                    controller: glabalScrollController,
                    visibleHeight: 85.h,
                    child: CustomBottomNav(
                      bottomNavController: bottomNavController,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

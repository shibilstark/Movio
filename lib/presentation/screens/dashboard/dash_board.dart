import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/presentation/screens/dashboard/appbar.dart';
import 'package:movio/presentation/screens/home/home_screen.dart';
import 'package:movio/presentation/widgets/scroll_to_hide.dart';

import 'bottom_nav.dart';

final ValueNotifier<int> bottomNavController = ValueNotifier<int>(0);
final ScrollController glabalScrollController = ScrollController();

class DashBoard extends StatelessWidget {
  DashBoard({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final _tabs = [
    HomeScreen(scrollController: glabalScrollController),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: const PreferredSize(
          preferredSize: AppSpecific.appBarHeight,
          child: CustomAppBar(
            showThemeSwitch: true,
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ValueListenableBuilder(
              valueListenable: bottomNavController,
              builder: (context, value, child) {
                return _tabs[value];
              },
            ),
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
  }
}

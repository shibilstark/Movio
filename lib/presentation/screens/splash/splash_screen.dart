import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movio/presentation/bloc/settings/settings_bloc.dart';
import 'package:movio/presentation/router/routers.dart';
import 'package:movio/presentation/screens/dashboard/dash_board.dart';

import '../../bloc/home/home_bloc.dart';
import '../../bloc/search_idle/search_idle_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SettingsBloc>().add(const LoadSettings());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashBoard()));
    });
    return Scaffold(
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsSuccess) {
            context.read<HomeBloc>().add(const LoadCollections());
            context.read<SearchIdleBloc>().add(LoadIdle());
            AppNavigator.pushReplacement(
                context: context, screenName: AppRouter.DASH_BOARD);
          } else {
            context.read<SettingsBloc>().add(const LoadSettings());
          }
        },
        child: const Center(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}

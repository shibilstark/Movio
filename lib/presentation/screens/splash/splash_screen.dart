import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movio/config/colors.dart';
import 'package:movio/config/dimensions.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/presentation/bloc/settings/settings_bloc.dart';
import 'package:movio/presentation/router/routers.dart';
import 'package:movio/presentation/widgets/error.dart';
import '../../../config/strings.dart';
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
    return Scaffold(
      body: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) async {
          if (state is SettingsSuccess) {
            context.read<HomeBloc>().add(const LoadCollections());
            context.read<SearchIdleBloc>().add(LoadIdle());
            await Future.delayed(const Duration(seconds: 2)).then((value) {
              AppNavigator.pushReplacement(
                  context: context, screenName: AppRouter.DASH_BOARD);
            });
          } else {
            context.read<SettingsBloc>().add(const LoadSettings());
          }
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.appName.toUpperCase(),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: AppFontWeight.bold,
                      fontSize: 32,
                      color: AppColors.orange,
                      letterSpacing: 4,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

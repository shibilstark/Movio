import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/build_config.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/config/themes.dart';
import 'package:movio/data/api/api.dart';
import 'package:movio/injector/injection.dart';
import 'package:movio/presentation/bloc/theme/theme_bloc.dart';

void main() async {
  await initializeDependancies();
  runApp(const MyApp());
}

Future<void> initializeDependancies() async {
  WidgetsFlutterBinding.ensureInitialized();

  BuildConfig.instantiate(
    environment: EnvironmentType.developement,
    config: Configuration(
      networkTimeOut: const Duration(seconds: 3),
      serverTimeOut: const Duration(seconds: 20),
      baseUrl: Api.baseUrl,
      appName: AppString.appName,
    ),
  );

  await configureInjection();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 900),
            splitScreenMode: true,
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                theme: state.isDarkMode ? AppThemes.dark : AppThemes.light,
                home: const HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.w,
        color: Colors.red,
        padding: EdgeInsets.all(20),
        height: 100.h,
        child: Text(
          "Hello World",
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
    );
  }
}

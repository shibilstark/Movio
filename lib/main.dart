import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movio/config/build_config.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/config/themes.dart';
import 'package:movio/data/api/api.dart';
import 'package:movio/injector/injection.dart';
import 'package:movio/presentation/bloc/home/home_bloc.dart';
import 'package:movio/presentation/bloc/more_movies/more_movies_bloc.dart';
import 'package:movio/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movio/presentation/bloc/movie_search/movie_search_bloc.dart';
import 'package:movio/presentation/bloc/search_idle/search_idle_bloc.dart';
import 'package:movio/presentation/bloc/settings/settings_bloc.dart';
import 'package:movio/presentation/bloc/theme/theme_bloc.dart';
import 'package:movio/presentation/router/routers.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SearchIdleBloc()),
        BlocProvider(create: (context) => MovieSearchBloc()),
        BlocProvider(create: (context) => MovieDetailBloc()),
        BlocProvider(create: (context) => MoreMoviesBloc()),
        BlocProvider(create: (context) => SettingsBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          context.read<ThemeBloc>().add(const LoadTheme());
          return ScreenUtilInit(
            designSize: const Size(360, 900),
            splitScreenMode: true,
            minTextAdapt: true,
            builder: (context, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: state.isDarkMode ? AppThemes.dark : AppThemes.light,
                onGenerateRoute: AppRouter.ongeneratedRoute,
                initialRoute: AppRouter.SPLASH_SCREEN,
              );
            },
          );
        },
      ),
    );
  }
}

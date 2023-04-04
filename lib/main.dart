import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movio/config/build_config.dart';
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
      baseUrl: Api().baseUrl,
      appName: "Movio",
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
          return MaterialApp(
            theme: state.isDarkMode ? AppThemes.dark : AppThemes.light,
            home: const HomeScreen(),
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
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              // final restult = await MovieRepositoryImpl()
              //     .search(query: "Marvel", pageNumber: 1);

              // restult.fold((l) {
              //   l.movies.forEach((element) {
              //     log(element.title);
              //   });
              // }, (r) {
              //   log(r.message);
              // });
            },
            child: const Text("call")),
      ),
    );
  }
}

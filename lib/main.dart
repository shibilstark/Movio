import 'package:flutter/material.dart';
import 'package:movio/config/build_config.dart';
import 'package:movio/data/api/api.dart';

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
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
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
              //     .getSimilarMovies(movieId: 76600, pageNumber: 1);

              // restult.fold((l) {
              //   log(l.movies.length.toString());
              // }, (r) {
              //   log(r.message);
              // });
            },
            child: Text("call")),
      ),
    );
  }
}

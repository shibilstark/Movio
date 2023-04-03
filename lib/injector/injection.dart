import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;
const _envKey = 'Prod';

@InjectableInit()
Future configureInjection() async {
  $initGetIt(
    getIt,
    environment: _envKey,
  );
}

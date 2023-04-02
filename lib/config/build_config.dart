enum EnvironmentType {
  developement,
  testing,
  production,
}

class BuildConfig {
  late final Configuration config;
  late final EnvironmentType environment;

  static final BuildConfig instance = BuildConfig._internal();

  BuildConfig._internal();

  factory BuildConfig.instantiate({
    required EnvironmentType environment,
    required Configuration config,
  }) {
    instance.environment = environment;
    instance.config = config;

    return instance;
  }
}

class Configuration {
  final Duration networkTimeOut;
  final Duration serverTimeOut;
  final String baseUrl;
  final String appName;

  Configuration({
    required this.networkTimeOut,
    required this.serverTimeOut,
    required this.baseUrl,
    required this.appName,
  });
}

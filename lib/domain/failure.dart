enum AppFailureType {
  internet,
  client,
  server,
}

class AppFailure {
  final String message;
  final AppFailureType type;

  AppFailure({
    required this.message,
    required this.type,
  });
}

enum MovieStatus {
  rumoured("Rumoured"),
  planned("Planned"),
  inProduction("In Production"),
  postProduction("Post Production"),
  released("Released"),
  cancelled("Cancelled");

  final String status;
  const MovieStatus(this.status);

  String getStatus() => status;
}

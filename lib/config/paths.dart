class ApiPaths {
  static String? image(String? url) =>
      url == null ? null : "https://image.tmdb.org/t/p/original/$url";
}

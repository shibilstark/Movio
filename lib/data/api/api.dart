class Api {
  static const _apiVersion = 3;
  final baseUrl = "https://api.themoviedb.org/$_apiVersion/";
  final key = "25f3c58447db49a695f3896cc954076d";
  final movieCollection = MovieCollectionEndPoint();
  MovieEndPoint movie(int id) => MovieEndPoint(id);
}

/// Will return the collection of movies
class MovieCollectionEndPoint {
  static const _moviePath = "movie/";
  final topRated = "$_moviePath/top_rated";
  final popular = "$_moviePath/popular";
  final nowPlaying = "$_moviePath/now_playing";
  final upcoming = "$_moviePath/upcoming";
  final latest = "$_moviePath/latest";
}

class MovieEndPoint {
  final int id;
  const MovieEndPoint(this.id);
  static const _moviePath = "movie/";

  /// Will return details about a movie
  String details() => "$_moviePath/$id";

  /// Will retuen similar movies
  String similar() => "$_moviePath/$id/similar";

  /// Will retuen  movie images
  String images() => "$_moviePath/$id/images";
}

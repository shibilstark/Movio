import 'package:movio/domain/movies/models/movie.dart';

class MovieCollection {
  final int currentPage;
  final int totalPages;
  final List<Movie> movies;

  MovieCollection({
    required this.currentPage,
    required this.totalPages,
    required this.movies,
  });
}

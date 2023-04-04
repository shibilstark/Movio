import 'package:equatable/equatable.dart';
import 'package:movio/domain/movies/models/movie.dart';

class MovieCollection extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<Movie> movies;

  MovieCollection({
    required this.currentPage,
    required this.totalPages,
    required this.movies,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, movies];
}

import 'package:equatable/equatable.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie.dart';

class MovieCollection extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<Movie> movies;

  const MovieCollection({
    required this.currentPage,
    required this.totalPages,
    required this.movies,
  });

  @override
  List<Object?> get props => [currentPage, totalPages, movies];
}

class MovieCollectionWithType extends Equatable {
  /// Possible values are null, MovieCollcection or App Failure
  final dynamic collection;
  final MovieCollectionType type;

  const MovieCollectionWithType({
    required this.collection,
    required this.type,
  });

  @override
  List<Object?> get props => [type, collection];
}

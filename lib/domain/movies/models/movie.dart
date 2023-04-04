import 'package:equatable/equatable.dart';
import 'package:movio/domain/movies/models/genre.dart';

class Movie extends Equatable {
  final String? posterPath;
  final bool isAdult;
  final String overview;
  final String releaseDate;
  final List<Genre> genreIds;
  final int id;
  final String originalTitle;
  final String title;

  final String? backdropPath;

  const Movie({
    this.posterPath,
    required this.isAdult,
    required this.overview,
    required this.releaseDate,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.title,
    this.backdropPath,
  });

  @override
  List<Object?> get props => [
        id,
        isAdult,
        title,
        releaseDate,
      ];
}

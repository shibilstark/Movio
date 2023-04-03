import 'package:movio/domain/movies/models/genre.dart';

class MovieDetails {
  final String? posterPath;
  final bool isAdult;
  final String overview;
  final int budget;
  final int revenue;
  final int? runtime;
  final String releaseDate;
  final List<Genre> genres;
  final int id;
  final String originalTitle;
  final String title;
  final String? backdropPath;
  final String originalLanguage;
  final double popularity;
  final String status;

  MovieDetails({
    this.posterPath,
    required this.isAdult,
    required this.overview,
    required this.releaseDate,
    required this.genres,
    required this.id,
    required this.originalTitle,
    required this.title,
    this.backdropPath,
    required this.budget,
    required this.originalLanguage,
    required this.popularity,
    required this.revenue,
    this.runtime,
    required this.status,
  });
}
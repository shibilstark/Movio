import 'package:json_annotation/json_annotation.dart';
import 'package:movio/data/movies/entities/genre_dto/genre_dto.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
part 'movie_detail_dto.g.dart';

@JsonSerializable()
class MovieDetailDto {
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'adult')
  final bool isAdult;
  @JsonKey(name: 'overview')
  final String overview;
  @JsonKey(name: 'budget')
  final int budget;
  @JsonKey(name: 'revenue')
  final int revenue;
  @JsonKey(name: 'runtime')
  final int? runtime;
  @JsonKey(name: 'release_date')
  final String releaseDate;
  @JsonKey(name: 'genres')
  final List<GenreDto> genres;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  @JsonKey(name: 'popularity')
  final double popularity;
  @JsonKey(name: 'status')
  final String status;

  MovieDetailDto({
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

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    return _$MovieDetailDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieDetailDtoToJson(this);

  MovieDetails toModel() => MovieDetails(
        isAdult: isAdult,
        overview: overview,
        releaseDate: releaseDate,
        genres: genres.map((e) => e.toModel()).toList(),
        id: id,
        originalTitle: originalTitle,
        title: title,
        budget: budget,
        originalLanguage: originalLanguage,
        popularity: popularity,
        revenue: revenue,
        status: status,
        backdropPath: backdropPath,
        posterPath: posterPath,
        runtime: runtime,
      );
}

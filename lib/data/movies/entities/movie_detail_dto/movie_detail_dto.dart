import 'package:json_annotation/json_annotation.dart';
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
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
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
    required this.genreIds,
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
}

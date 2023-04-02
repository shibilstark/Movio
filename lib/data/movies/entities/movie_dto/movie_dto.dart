// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:movio/domain/movies/models/genre.dart';
import 'package:movio/domain/movies/models/movie.dart';

part 'movie_dto.g.dart';

// Popular, TopRated, NowPlaying, Upcoming, Latest, SimilarMovie

@JsonSerializable()
class MovieDto {
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'adult')
  final bool isAdult;
  @JsonKey(name: 'overview')
  final String overview;
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

  MovieDto({
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

  factory MovieDto.fromJson(Map<String, dynamic> json) {
    return _$MovieDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);

  Movie toModel() {
    return Movie(
      isAdult: isAdult,
      overview: overview,
      releaseDate: releaseDate,
      genreIds: genreIds.map((e) => Genre.fromId(e)).toList(),
      id: id,
      originalTitle: originalTitle,
      title: title,
      backdropPath: backdropPath,
      posterPath: posterPath,
    );
  }
}

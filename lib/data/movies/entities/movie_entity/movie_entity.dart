// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'movie_entity.g.dart';

// Popular, TopRated, NowPlaying, Upcoming, Latest, SimilarMovie

@JsonSerializable()
class MovieEntity {
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

  MovieEntity({
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

  factory MovieEntity.fromJson(Map<String, dynamic> json) {
    return _$MovieEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieEntityToJson(this);

  @override
  String toString() {
    return 'MovieEntity(posterPath: $posterPath, isAdult: $isAdult, overview: $overview, releaseDate: $releaseDate, genreIds: $genreIds, id: $id, originalTitle: $originalTitle, title: $title, backdropPath: $backdropPath)';
  }
}

import 'package:json_annotation/json_annotation.dart';
import 'package:movio/data/movies/entities/movie_dto/movie_dto.dart';
import 'package:movio/domain/movies/models/movie.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
part 'pagineted_dto.g.dart';

@JsonSerializable()
class PaginatedDto {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "total_pages")
  final int totalPages;
  @JsonKey(name: "results")
  final List<dynamic> results;

  PaginatedDto({
    required this.page,
    required this.totalPages,
    required this.results,
  });

  factory PaginatedDto.fromJson(Map<String, dynamic> json) {
    return _$PaginatedDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginatedDtoToJson(this);

  MovieCollection toModel() {
    return MovieCollection(
      currentPage: page,
      totalPages: totalPages,
      movies: results.map((e) => MovieDto.fromJson(e).toModel()).toList(),
    );
  }
}

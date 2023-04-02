import 'package:json_annotation/json_annotation.dart';
import 'package:movio/domain/movies/models/genre.dart';
part 'genre_dto.g.dart';

@JsonSerializable()
class GenreDto {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'id')
  final int id;

  GenreDto({
    required this.name,
    required this.id,
  });

  factory GenreDto.fromJson(Map<String, dynamic> json) {
    return _$GenreDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GenreDtoToJson(this);

  Genre toModel() {
    return Genre(id: id, name: name);
  }
}

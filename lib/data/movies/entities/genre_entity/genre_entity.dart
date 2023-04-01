import 'package:json_annotation/json_annotation.dart';
part 'genre_entity.g.dart';

@JsonSerializable()
class GenreEntity {
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'id')
  final int id;

  GenreEntity({
    required this.name,
    required this.id,
  });

  factory GenreEntity.fromJson(Map<String, dynamic> json) {
    return _$GenreEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GenreEntityToJson(this);
}

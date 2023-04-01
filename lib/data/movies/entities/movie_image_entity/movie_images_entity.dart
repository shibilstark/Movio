import 'package:json_annotation/json_annotation.dart';
part 'movie_images_entity.g.dart';

@JsonSerializable()
class MovieImagesEntity {
  @JsonKey(name: 'backdrops')
  final List<MoviePostersOrBackdropEntity> backdrops;
  @JsonKey(name: 'posters')
  final List<MoviePostersOrBackdropEntity> posters;
  @JsonKey(name: 'id')
  final int id;

  MovieImagesEntity({
    required this.backdrops,
    required this.posters,
    required this.id,
  });

  factory MovieImagesEntity.fromJson(Map<String, dynamic> json) {
    return _$MovieImagesEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieImagesEntityToJson(this);
}

@JsonSerializable()
class MoviePostersOrBackdropEntity {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'width')
  final int width;

  MoviePostersOrBackdropEntity({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.width,
  });

  factory MoviePostersOrBackdropEntity.fromJson(Map<String, dynamic> json) {
    return _$MoviePostersOrBackdropEntityFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MoviePostersOrBackdropEntityToJson(this);
}

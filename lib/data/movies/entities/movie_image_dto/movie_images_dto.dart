import 'package:json_annotation/json_annotation.dart';
import 'package:movio/domain/movies/models/movie_image.dart';
part 'movie_images_dto.g.dart';

@JsonSerializable()
class MovieImagesDto {
  @JsonKey(name: 'backdrops')
  final List<MoviePostersOrBackdropDto> backdrops;
  @JsonKey(name: 'posters')
  final List<MoviePostersOrBackdropDto> posters;
  @JsonKey(name: 'id')
  final int id;

  MovieImagesDto({
    required this.backdrops,
    required this.posters,
    required this.id,
  });

  factory MovieImagesDto.fromJson(Map<String, dynamic> json) {
    return _$MovieImagesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MovieImagesDtoToJson(this);

  MovieImage toModel() {
    return MovieImage(
      id: id,
      backdrops: backdrops.map((e) => e.toModel()).toList(),
      posters: posters.map((e) => e.toModel()).toList(),
    );
  }
}

@JsonSerializable()
class MoviePostersOrBackdropDto {
  @JsonKey(name: 'aspect_ratio')
  final double aspectRatio;
  @JsonKey(name: 'file_path')
  final String filePath;
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'width')
  final int width;

  MoviePostersOrBackdropDto({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.width,
  });

  factory MoviePostersOrBackdropDto.fromJson(Map<String, dynamic> json) {
    return _$MoviePostersOrBackdropDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MoviePostersOrBackdropDtoToJson(this);

  MovieImageData toModel() {
    return MovieImageData(
      aspectRatio: aspectRatio,
      filePath: filePath,
      height: height,
      width: width,
    );
  }
}

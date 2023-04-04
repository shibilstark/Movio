import 'package:equatable/equatable.dart';

class MovieImage extends Equatable {
  final List<MovieImageData> backdrops;
  final List<MovieImageData> posters;
  final int id;

  MovieImage({
    required this.backdrops,
    required this.posters,
    required this.id,
  });

  @override
  List<Object?> get props => [id];
}

class MovieImageData extends Equatable {
  final double aspectRatio;
  final String filePath;
  final int height;
  final int width;

  MovieImageData({
    required this.aspectRatio,
    required this.filePath,
    required this.height,
    required this.width,
  });

  @override
  List<Object?> get props => [filePath];
}

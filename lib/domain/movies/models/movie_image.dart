class MovieImage {
  final List<MovieImageData> backdrops;
  final List<MovieImageData> posters;
  final int id;

  MovieImage({
    required this.backdrops,
    required this.posters,
    required this.id,
  });
}

class MovieImageData {
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
}

import 'package:dartz/dartz.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
import 'package:movio/domain/movies/models/movie_image.dart';

abstract class MovieRepository {
  Future<Either<MovieCollection, AppFailure>> getMoviesCollection({
    required MovieCollectionType type,
    required int pageNumber,
  });

  Future<Either<MovieDetails, AppFailure>> getMovie({
    required int id,
  });

  Future<Either<MovieImage, AppFailure>> getMovieImages({
    required int id,
  });

  Future<Either<MovieCollection, AppFailure>> getSimilarMovies({
    required int pageNumber,
    required int movieId,
  });
}

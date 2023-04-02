import 'package:dartz/dartz.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
import 'package:movio/domain/movies/models/movie_image.dart';

abstract class MovieRepository {
  Either<MovieCollection, AppFailure> getMoviesCollection({
    required MovieCollectionType type,
    required int pageNumber,
  });

  Either<MovieDetails, AppFailure> getMovie({
    required int id,
  });

  Either<MovieImage, AppFailure> getMovieImages({
    required int id,
  });

  Either<MovieCollection, AppFailure> getSimilarMovies({
    required int pageNumber,
    required int movieId,
  });
}

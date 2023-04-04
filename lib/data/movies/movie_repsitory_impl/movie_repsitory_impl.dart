import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:movio/data/movies/movies_api/movies_api.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
import 'package:movio/domain/movies/models/movie_image.dart';
import 'package:movio/domain/movies/repository/movie_repository.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  final moviesApi = MoviesApi();
  @override
  Future<Either<MovieDetails, AppFailure>> getMovie({required int id}) {
    return moviesApi.getMovie(id: id);
  }

  @override
  Future<Either<MovieImage, AppFailure>> getMovieImages({required int id}) {
    return moviesApi.getMovieImages(id: id);
  }

  @override
  Future<Either<MovieCollection, AppFailure>> getMoviesCollection(
      {required MovieCollectionType type, required int pageNumber}) {
    return moviesApi.getMoviesCollection(type: type, pageNumber: pageNumber);
  }

  @override
  Future<Either<MovieCollection, AppFailure>> getSimilarMovies(
      {required int pageNumber, required int movieId}) {
    return moviesApi.getSimilarMovies(movieId: movieId, pageNumber: pageNumber);
  }

  @override
  Future<Either<MovieCollection, AppFailure>> search(
      {required String query, required int pageNumber}) {
    return moviesApi.search(query: query, pageNumber: pageNumber);
  }
}

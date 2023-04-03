import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movio/data/api/api.dart';
import 'package:movio/data/movies/entities/movie_detail_dto/movie_detail_dto.dart';
import 'package:movio/data/movies/entities/movie_image_dto/movie_images_dto.dart';
import 'package:movio/data/movies/entities/pagineted_dto/pagineted_dto.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/models/movie_image.dart';
import 'package:movio/packages/network/app_network.dart';

import '../../../domain/movies/models/movie_detail.dart';

class MoviesApi {
  final client = AppNetwork();
  final api = Api();
  final _apiKey = "api_key";
  final _pageKey = "page";
  final _queryKey = "query";
  final _includeAdultKey = "include_adult";

  Future<Either<MovieCollection, AppFailure>> getMoviesCollection({
    required MovieCollectionType type,
    required int pageNumber,
  }) async {
    try {
      final url = api.baseUrl + _getCollectionByType(type);

      final result = await client.get(url: url, queryParameters: {
        _apiKey: api.key,
        _pageKey: pageNumber,
      });
      return result.fold((respnse) {
        if (client.isValidResponse(respnse.statusCode)) {
          final dto = PaginatedDto.fromJson(respnse.data);
          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message:
                "Response invalid Something went wrong please try again later",
            type: AppFailureType.server,
          ));
        }
      }, (error) {
        return Right(AppFailure(
          message: error.message,
          type: AppFailureType.client,
        ));
      });
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      return Right(AppFailure(
        message: e.toString(),
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieCollection, AppFailure>> search({
    required String query,
    required int pageNumber,
  }) async {
    try {
      final url = api.baseUrl + api.movieCollection.search;

      final result = await client.get(url: url, queryParameters: {
        _apiKey: api.key,
        _pageKey: pageNumber,
        _queryKey: query,
        _includeAdultKey: true,
      });
      return result.fold((respnse) {
        if (client.isValidResponse(respnse.statusCode)) {
          final dto = PaginatedDto.fromJson(respnse.data);
          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message:
                "Response invalid Something went wrong please try again later",
            type: AppFailureType.server,
          ));
        }
      }, (error) {
        return Right(AppFailure(
          message: error.message,
          type: AppFailureType.client,
        ));
      });
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      return Right(AppFailure(
        message: e.toString(),
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieDetails, AppFailure>> getMovie({
    required int id,
  }) async {
    try {
      final url = api.baseUrl + api.movie(id).details();

      final result = await client.get(url: url, queryParameters: {
        _apiKey: api.key,
      });
      return result.fold((respnse) {
        if (client.isValidResponse(respnse.statusCode)) {
          final dto = MovieDetailDto.fromJson(respnse.data);

          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message:
                "Response invalid Something went wrong please try again later",
            type: AppFailureType.server,
          ));
        }
      }, (error) {
        return Right(AppFailure(
          message: error.message,
          type: AppFailureType.client,
        ));
      });
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      return Right(AppFailure(
        message: e.toString(),
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieImage, AppFailure>> getMovieImages({
    required int id,
  }) async {
    try {
      final url = api.baseUrl + api.movie(id).images();

      final result = await client.get(url: url, queryParameters: {
        _apiKey: api.key,
      });
      return result.fold((respnse) {
        if (client.isValidResponse(respnse.statusCode)) {
          final dto = MovieImagesDto.fromJson(respnse.data);

          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message:
                "Response invalid Something went wrong please try again later",
            type: AppFailureType.server,
          ));
        }
      }, (error) {
        return Right(AppFailure(
          message: error.message,
          type: AppFailureType.client,
        ));
      });
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      return Right(AppFailure(
        message: e.toString(),
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieCollection, AppFailure>> getSimilarMovies({
    required int pageNumber,
    required int movieId,
  }) async {
    try {
      final url = api.baseUrl + api.movie(movieId).similar();

      final result = await client.get(url: url, queryParameters: {
        _apiKey: api.key,
        _pageKey: pageNumber,
      });
      return result.fold((respnse) {
        if (client.isValidResponse(respnse.statusCode)) {
          final dto = PaginatedDto.fromJson(respnse.data);
          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message:
                "Response invalid Something went wrong please try again later",
            type: AppFailureType.server,
          ));
        }
      }, (error) {
        return Right(AppFailure(
          message: error.message,
          type: AppFailureType.client,
        ));
      });
    } catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      return Right(AppFailure(
        message: e.toString(),
        type: AppFailureType.client,
      ));
    }
  }

  String _getCollectionByType(MovieCollectionType type) {
    final Map<MovieCollectionType, String> collectionMap = {
      MovieCollectionType.nowPlaying: api.movieCollection.nowPlaying,
      MovieCollectionType.popular: api.movieCollection.popular,
      MovieCollectionType.topRated: api.movieCollection.topRated,
      MovieCollectionType.upcoming: api.movieCollection.upcoming,
      MovieCollectionType.trending: api.movieCollection.trending,
    };
    return collectionMap[type] ?? api.movieCollection.popular;
  }
}

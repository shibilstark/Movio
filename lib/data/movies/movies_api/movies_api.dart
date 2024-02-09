import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/data/api/api.dart';
import 'package:movio/data/movies/entities/movie_detail_dto/movie_detail_dto.dart';
import 'package:movio/data/movies/entities/movie_image_dto/movie_images_dto.dart';
import 'package:movio/data/movies/entities/pagineted_dto/pagineted_dto.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/models/movie_image.dart';
import 'package:movio/global/user_data.dart';
import 'package:movio/packages/network/app_network.dart';

import '../../../domain/movies/models/movie_detail.dart';

class MoviesApi {
  final _apiKey = "api_key";
  final _pageKey = "page";
  final _queryKey = "query";
  final _includeAdultKey = "include_adult";

  Future<Either<MovieCollection, AppFailure>> getMoviesCollection({
    required MovieCollectionType type,
    required int pageNumber,
  }) async {
    try {
      final url = Api.baseUrl + _getCollectionByType(type);

      final result = await AppNetwork.get(url: url, queryParameters: {
        _apiKey: Api.key,
        _pageKey: pageNumber,
      });
      return result.fold((respnse) {
        if (AppNetwork.isValidResponse(respnse.statusCode)) {
          final dto = PaginatedDto.fromJson(respnse.data);
          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message: AppString.serverFailure,
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
        message: AppString.somethingWentWrong,
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieCollection, AppFailure>> search({
    required String query,
    required int pageNumber,
  }) async {
    try {
      final url = Api.baseUrl + Api.movieCollection.search;

      final result = await AppNetwork.get(url: url, queryParameters: {
        _apiKey: Api.key,
        _pageKey: pageNumber,
        _queryKey: query,
        _includeAdultKey: UserData.nsfwContentStatus,
      });
      return result.fold((respnse) {
        if (AppNetwork.isValidResponse(respnse.statusCode)) {
          final dto = PaginatedDto.fromJson(respnse.data);
          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message: AppString.serverFailure,
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
        message: AppString.somethingWentWrong,
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieDetails, AppFailure>> getMovie({
    required int id,
  }) async {
    try {
      final url = Api.baseUrl + Api.movie(id).details();

      final result = await AppNetwork.get(url: url, queryParameters: {
        _apiKey: Api.key,
      });
      return result.fold((respnse) {
        if (AppNetwork.isValidResponse(respnse.statusCode)) {
          final dto = MovieDetailDto.fromJson(respnse.data);

          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message: AppString.serverFailure,
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
        message: AppString.somethingWentWrong,
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieImage, AppFailure>> getMovieImages({
    required int id,
  }) async {
    try {
      final url = Api.baseUrl + Api.movie(id).images();

      final result = await AppNetwork.get(url: url, queryParameters: {
        _apiKey: Api.key,
      });
      return result.fold((respnse) {
        if (AppNetwork.isValidResponse(respnse.statusCode)) {
          final dto = MovieImagesDto.fromJson(respnse.data);

          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message: AppString.serverFailure,
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
        message: AppString.somethingWentWrong,
        type: AppFailureType.client,
      ));
    }
  }

  Future<Either<MovieCollection, AppFailure>> getSimilarMovies({
    required int pageNumber,
    required int movieId,
  }) async {
    try {
      final url = Api.baseUrl + Api.movie(movieId).similar();

      final result = await AppNetwork.get(url: url, queryParameters: {
        _apiKey: Api.key,
        _pageKey: pageNumber,
      });
      return result.fold((respnse) {
        if (AppNetwork.isValidResponse(respnse.statusCode)) {
          final dto = PaginatedDto.fromJson(respnse.data);
          return Left(dto.toModel());
        } else {
          return Right(AppFailure(
            message: AppString.serverFailure,
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
        message: AppString.somethingWentWrong,
        type: AppFailureType.client,
      ));
    }
  }

  String _getCollectionByType(MovieCollectionType type) {
    final Map<MovieCollectionType, String> collectionMap = {
      MovieCollectionType.nowPlaying: Api.movieCollection.nowPlaying,
      MovieCollectionType.popular: Api.movieCollection.popular,
      MovieCollectionType.topRated: Api.movieCollection.topRated,
      MovieCollectionType.upcoming: Api.movieCollection.upcoming,
      MovieCollectionType.trending: Api.movieCollection.trending,
    };
    return collectionMap[type] ?? Api.movieCollection.popular;
  }
}

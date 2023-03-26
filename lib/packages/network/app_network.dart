import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movio/packages/network/dio_failure.dart';
import '../../config/build_config.dart';

class AppNetwork {
  final BaseOptions baseOptions = BaseOptions(
    receiveDataWhenStatusError: true,
    sendTimeout: BuildConfig.instance.config.serverTimeOut.inSeconds * 1000,
    connectTimeout: BuildConfig.instance.config.serverTimeOut.inSeconds * 1000,
    receiveTimeout: BuildConfig.instance.config.serverTimeOut.inSeconds * 1000,
  );
  Future<Either<Response<dynamic>, DioFailure>> get({
    required String url,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final res = await Dio(
        baseOptions..queryParameters = queryParameters ?? {},
      ).get(url);

      return Left(res);
    } on DioError catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return Right(DioFailure(message: "", statusCode: 404));
      }
      if (e.type == DioErrorType.response) {
        return Right(DioFailure(message: "", statusCode: 404));
      }
      return Right(DioFailure(message: "", statusCode: 404));
    }
  }

  Future<Either<Response<dynamic>, DioFailure>> post({
    required String url,
    Map<String, dynamic>? queryParameters,
    required Map<String, dynamic>? data,
  }) async {
    try {
      final res = await Dio(baseOptions).post(url, data: data);

      return Left(res);
    } on DioError catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        return Right(DioFailure(message: "", statusCode: 404));
      }
      if (e.type == DioErrorType.response) {
        return Right(DioFailure(message: "", statusCode: 404));
      }
      return Right(DioFailure(message: "", statusCode: 404));
    }
  }

  bool checkUnAuthorized(int statusCode) {
    if (statusCode == 401) {
      return true;
    } else {
      return false;
    }
  }

  String fetchMessage(Response res) {
    return res.data['message'] as String;
  }

  bool isValidResponse(Response res) {
    if (res.statusCode == 200 || res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}

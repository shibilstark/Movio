import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
      return Right(DioFailure(message: e.message));
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
      return Right(DioFailure(message: e.message));
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

  bool isValidResponse(int? statusCode) {
    if (statusCode == 200 || statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}

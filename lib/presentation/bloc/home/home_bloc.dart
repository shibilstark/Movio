import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/repository/movie_repository.dart';
import 'package:movio/injector/injection.dart';
import 'package:movio/utils/connectivity/connectivity_util.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<LoadCollections>(_loadCollections);
    on<ReloadSingleCollection>(_loadErrorCollection);
  }

  void _loadCollections(LoadCollections event, Emitter<HomeState> emit) async {
    emit(HomeLoading());

    if (await _haveInternetConnection()) {
      Map<MovieCollectionType, Either<MovieCollection, AppFailure>?>
          collectionMap = {};

      for (MovieCollectionType val in MovieCollectionType.values) {
        final result = await getIt<MovieRepository>()
            .getMoviesCollection(type: val, pageNumber: 1);
        collectionMap[val] = result;
        emit(HomeSuccess(collectionMap: Map.from(collectionMap)));
      }
    } else {
      emit(HomeError(AppFailure(
          message: AppString.noInternet, type: AppFailureType.internet)));
    }
  }

  void _loadErrorCollection(
      ReloadSingleCollection event, Emitter<HomeState> emit) async {
    if (await _haveInternetConnection()) {
      final currentState = state;

      if (currentState is HomeSuccess) {
        final result = await getIt<MovieRepository>()
            .getMoviesCollection(type: event.type, pageNumber: 1);
        currentState.collectionMap[event.type] = result;
        emit(HomeSuccess(collectionMap: Map.from(currentState.collectionMap)));
      } else {
        emit(currentState);
      }
    }
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

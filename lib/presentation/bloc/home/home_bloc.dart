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
import 'package:movio/utils/date_time/date_time_util.dart';

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
      List<MovieCollectionWithType> allCollections = [];

      for (MovieCollectionType val in MovieCollectionType.values) {
        final result = await getIt<MovieRepository>()
            .getMoviesCollection(type: val, pageNumber: 1);

        allCollections.add(
          convertToTypedCollection(result, val),
        );
      }

      emit(
        HomeSuccess(
            timeStamp: DateUtil.getTimeStamp(),
            allCollections: List.from(allCollections)),
      );
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

        HomeSuccess(
          timeStamp: DateUtil.getTimeStamp(),
          allCollections: List.from(currentState.allCollections)
            ..removeWhere((element) => element.type == event.type)
            ..add(
              convertToTypedCollection(result, event.type),
            ),
        );
      } else {
        emit(currentState);
      }
    }
  }

  MovieCollectionWithType convertToTypedCollection(
      Either<MovieCollection, AppFailure>? result, MovieCollectionType type) {
    if (result == null) {
      return MovieCollectionWithType(collection: null, type: type);
    }

    return result.fold(
        (l) => MovieCollectionWithType(collection: l, type: type),
        (r) => MovieCollectionWithType(collection: r, type: type));
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

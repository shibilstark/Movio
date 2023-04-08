import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/repository/movie_repository.dart';
import 'package:movio/injector/injection.dart';

import '../../../config/strings.dart';
import '../../../utils/connectivity/connectivity_util.dart';

part 'more_movies_event.dart';
part 'more_movies_state.dart';

class MoreMoviesBloc extends Bloc<MoreMoviesEvent, MoreMoviesState> {
  MoreMoviesBloc() : super(MoreMoviesInitial()) {
    on<GetCollection>(_loadCollection);
    on<GetSimilarMovies>(_loadSimilarMovies);
    on<ReLoadCollection>(_reloadCollection);
    on<ReLoadSimilarMovies>(_reloadSimilarMovies);
  }

  void _loadCollection(
      GetCollection event, Emitter<MoreMoviesState> emit) async {
    emit(MoreMoviesLoading());

    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .getMoviesCollection(type: event.type, pageNumber: 1)
          .then((result) {
        result.fold((collection) {
          emit(MoreMoviesSuccess(similarCollection: collection));
        }, (error) {
          emit(MoreMoviesError(error));
        });
      });
    } else {
      emit(MoreMoviesError(AppFailure(
        message: AppString.noInternet,
        type: AppFailureType.internet,
      )));
    }
  }

  void _reloadCollection(
      ReLoadCollection event, Emitter<MoreMoviesState> emit) async {
    final currentState = state;

    if (currentState is MoreMoviesSuccess) {
      emit(MoreMoviesSuccess(
        similarCollection: currentState.similarCollection,
        isReloading: true,
      ));

      if (await _haveInternetConnection()) {
        await getIt<MovieRepository>()
            .getMoviesCollection(
                type: event.type,
                pageNumber: currentState.similarCollection.currentPage + 1)
            .then((result) {
          result.fold((collection) {
            emit(MoreMoviesSuccess(
                similarCollection: MovieCollection(
                    currentPage: collection.currentPage,
                    totalPages: collection.totalPages,
                    movies: List.from(currentState.similarCollection.movies)
                      ..addAll(collection.movies))));
          }, (error) {});
        });
      }
    }
  }

  void _loadSimilarMovies(
      GetSimilarMovies event, Emitter<MoreMoviesState> emit) async {
    emit(MoreMoviesLoading());

    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .getSimilarMovies(movieId: event.movieId, pageNumber: 1)
          .then((result) {
        result.fold((collection) {
          emit(MoreMoviesSuccess(similarCollection: collection));
        }, (error) {
          emit(MoreMoviesError(error));
        });
      });
    } else {
      emit(MoreMoviesError(AppFailure(
        message: AppString.noInternet,
        type: AppFailureType.internet,
      )));
    }
  }

  void _reloadSimilarMovies(
      ReLoadSimilarMovies event, Emitter<MoreMoviesState> emit) async {
    final currentState = state;

    if (currentState is MoreMoviesSuccess) {
      emit(MoreMoviesSuccess(
        similarCollection: currentState.similarCollection,
        isReloading: true,
      ));
      if (await _haveInternetConnection()) {
        await getIt<MovieRepository>()
            .getSimilarMovies(
                movieId: event.movieId,
                pageNumber: currentState.similarCollection.currentPage + 1)
            .then((result) {
          result.fold((collection) {
            emit(MoreMoviesSuccess(
                similarCollection: MovieCollection(
                    currentPage: collection.currentPage,
                    totalPages: collection.totalPages,
                    movies: List.from(currentState.similarCollection.movies)
                      ..addAll(collection.movies))));
          }, (error) {
            emit(MoreMoviesSuccess(
              similarCollection: currentState.similarCollection,
            ));
          });
        });
      } else {
        emit(MoreMoviesSuccess(
          similarCollection: currentState.similarCollection,
        ));
      }
    }
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

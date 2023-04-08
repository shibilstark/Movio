import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/models/movie_detail.dart';
import 'package:movio/domain/movies/repository/movie_repository.dart';
import 'package:movio/injector/injection.dart';
import 'package:movio/utils/connectivity/connectivity_util.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<LoadMovieDetails>(_loadMovieDetail);
    on<LoadMovieImages>(_loadMovieImages);
  }

  void _loadMovieDetail(
      LoadMovieDetails event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());

    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .getMovie(id: event.movieId)
          .then((result) async {
        await result.fold(
          (details) async {
            emit(MovieDetailSuccess(movie: details, movieImages: null));
            await _loadMovieImages(LoadMovieImages(event.movieId), emit);
          },
          (error) {
            emit(MovieDetailError(error));
          },
        );
      });
    } else {
      emit(MovieDetailError(
        AppFailure(
            message: AppString.noInternet, type: AppFailureType.internet),
      ));
    }
  }

  Future _loadMovieImages(
      LoadMovieImages event, Emitter<MovieDetailState> emit) async {
    final currentState = state;

    if (currentState is MovieDetailSuccess) {
      if (await _haveInternetConnection()) {
        await getIt<MovieRepository>()
            .getMovieImages(id: event.movieId)
            .then((result) {
          result.fold(
            (details) {
              emit(MovieDetailSuccess(
                  movie: currentState.movie, movieImages: details));
            },
            (error) {
              emit(MovieDetailSuccess(
                  movie: currentState.movie, movieImages: error));
            },
          );
        });
      } else {}
    }
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

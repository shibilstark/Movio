import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/repository/movie_repository.dart';
import 'package:movio/injector/injection.dart';
import 'package:movio/utils/connectivity/connectivity_util.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  MovieSearchBloc() : super(MovieSearchInitial()) {
    on<SearchMovie>(_searchMovie);
    on<LoadNewResults>(_loadNewPage);
  }
  void _searchMovie(SearchMovie event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());
    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .search(query: event.query.trim(), pageNumber: 1)
          .then((result) {
        result.fold((collection) {
          emit(MovieSearchSuccess(collection: collection));
        }, (error) {
          emit(MovieSearchError(error));
        });
      });
    } else {
      emit(MovieSearchError(
        AppFailure(
            message: AppString.noInternet, type: AppFailureType.internet),
      ));
    }
  }

  void _loadNewPage(
      LoadNewResults event, Emitter<MovieSearchState> emit) async {
    final currentState = state;

    if (currentState is MovieSearchSuccess) {
      emit(MovieSearchSuccess(
          collection: currentState.collection, isReloading: true));

      if (await _haveInternetConnection()) {
        await getIt<MovieRepository>()
            .search(
                query: event.query.trim(),
                pageNumber: currentState.collection.currentPage + 1)
            .then((result) {
          result.fold((collection) {
            final currentState = state;
            if (currentState is MovieSearchSuccess) {
              emit(MovieSearchSuccess(
                  collection: MovieCollection(
                      currentPage: collection.currentPage,
                      totalPages: collection.totalPages,
                      movies: List.from(currentState.collection.movies)
                        ..addAll(collection.movies)
                        ..toSet()
                        ..toList())));
            } else {
              emit(MovieSearchSuccess(collection: collection));
            }
          }, (error) {
            emit(MovieSearchError(error));
          });
        });
      } else {
        emit(MovieSearchSuccess(
            collection: currentState.collection, isReloading: false));
      }
    }
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

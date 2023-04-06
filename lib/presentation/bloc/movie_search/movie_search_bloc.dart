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
    on<LoadNewPage>(_loadNewPage);
  }
  void _searchMovie(SearchMovie event, Emitter<MovieSearchState> emit) async {
    emit(MovieSearchLoading());
    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .search(query: event.query.trim(), pageNumber: 0)
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

  void _loadNewPage(LoadNewPage event, Emitter<MovieSearchState> emit) async {
    _emitLoadingForSuccess(emit);
    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .search(query: event.query.trim(), pageNumber: event.page)
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
      emit(MovieSearchError(
        AppFailure(
            message: AppString.noInternet, type: AppFailureType.internet),
      ));
    }
  }

  _emitLoadingForSuccess(Emitter<MovieSearchState> e) {
    final currentState = state;
    if (currentState is MovieSearchSuccess) {
      e(MovieSearchSuccess(
          collection: currentState.collection, isReloading: true));
    } else {
      e(currentState);
    }
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

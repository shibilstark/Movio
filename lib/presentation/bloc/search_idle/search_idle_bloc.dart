import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movio/config/strings.dart';
import 'package:movio/domain/failure.dart';
import 'package:movio/domain/movies/enums/movie_enums.dart';
import 'package:movio/domain/movies/models/movie_collection.dart';
import 'package:movio/domain/movies/repository/movie_repository.dart';
import 'package:movio/injector/injection.dart';
import 'package:movio/utils/connectivity/connectivity_util.dart';
import 'package:movio/utils/date_time/date_time_util.dart';

part 'search_idle_event.dart';
part 'search_idle_state.dart';

class SearchIdleBloc extends Bloc<SearchIdleEvent, SearchIdleState> {
  SearchIdleBloc() : super(SearchIdleInitial()) {
    on<LoadIdle>(_laodIdle);
    on<LoadNewPage>(_laodNewPage);
  }

  void _laodIdle(LoadIdle event, Emitter<SearchIdleState> emit) async {
    emit(SearchIdleLoading());
    if (await _haveInternetConnection()) {
      await getIt<MovieRepository>()
          .getMoviesCollection(
              type: MovieCollectionType.trending, pageNumber: 1)
          .then((result) {
        result.fold((collection) {
          emit(SearchIdleSuccess(
            collection: collection,
            timeStamp: DateUtil.getTimeStamp(),
          ));
        }, (error) {
          emit(SearchIdleError(error));
        });
      });
    } else {
      emit(SearchIdleError(
        AppFailure(
            message: AppString.noInternet, type: AppFailureType.internet),
      ));
    }
  }

  void _laodNewPage(LoadNewPage event, Emitter<SearchIdleState> emit) async {
    final currentState = state;
    if (currentState is SearchIdleSuccess) {
      emit(SearchIdleSuccess(
        timeStamp: DateUtil.getTimeStamp(),
        collection: currentState.collection,
        isReloading: true,
      ));

      if (await _haveInternetConnection()) {
        await getIt<MovieRepository>()
            .getMoviesCollection(
                type: MovieCollectionType.trending,
                pageNumber: currentState.collection.currentPage + 1)
            .then((result) {
          result.fold((collection) {
            emit(SearchIdleSuccess(
                timeStamp: DateUtil.getTimeStamp(),
                collection: MovieCollection(
                  currentPage: collection.currentPage,
                  movies: [
                    ...currentState.collection.movies,
                    ...collection.movies
                  ].toSet().toList(),
                  totalPages: collection.totalPages,
                )));
          }, (error) {
            emit(SearchIdleError(error));
          });
        });
      } else {
        emit(SearchIdleError(
          AppFailure(
              message: AppString.noInternet, type: AppFailureType.internet),
        ));
      }
    } else {
      _laodIdle(LoadIdle(), emit);
    }
  }

  Future<bool> _haveInternetConnection() =>
      ConnectivityUtil().checkInernetConnectivity();
}

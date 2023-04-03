part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchState extends Equatable {}

class MovieSearchInitial extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class MovieSearchSuccess extends MovieSearchState {
  final MovieCollection collection;
  final bool isReloading;

  MovieSearchSuccess({
    required this.collection,
    this.isReloading = false,
  });

  @override
  List<Object?> get props => [collection, isReloading];
}

class MovieSearchError extends MovieSearchState {
  final AppFailure error;

  MovieSearchError(this.error);

  @override
  List<Object?> get props => [error];
}

class MovieSearchLoading extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

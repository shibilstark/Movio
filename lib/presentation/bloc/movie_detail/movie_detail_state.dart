part of 'movie_detail_bloc.dart';

abstract class MovieDetailState implements Equatable {
  const MovieDetailState();
}

class MovieDetailInitial extends MovieDetailState {
  @override
  List<Object> get props => [];

  @override
  bool? get stringify => throw UnimplementedError();
}

class MovieDetailSuccess extends MovieDetailState {
  final MovieDetails movie;
  final dynamic movieImages;

  const MovieDetailSuccess({
    required this.movie,
    required this.movieImages,
  });

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [movie, movieImages];
}

class MovieDetailLoading extends MovieDetailState {
  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [];
}

class MovieDetailError extends MovieDetailState {
  final AppFailure error;

  const MovieDetailError(this.error);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [error];
}

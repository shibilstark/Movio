part of 'more_movies_bloc.dart';

abstract class MoreMoviesState extends Equatable {
  const MoreMoviesState();

  @override
  List<Object> get props => [];
}

class MoreMoviesInitial extends MoreMoviesState {}

class MoreMoviesSuccess extends MoreMoviesState {
  final MovieCollection similarCollection;
  final bool isReloading;

  const MoreMoviesSuccess({
    required this.similarCollection,
    this.isReloading = false,
  });
  @override
  List<Object> get props => [similarCollection, isReloading];
}

class MoreMoviesLoading extends MoreMoviesState {}

class MoreMoviesError extends MoreMoviesState {
  final AppFailure error;

  const MoreMoviesError(this.error);
  @override
  List<Object> get props => [error];
}

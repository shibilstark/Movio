part of 'search_idle_bloc.dart';

abstract class SearchIdleState extends Equatable {
  const SearchIdleState();
}

class SearchIdleInitial extends SearchIdleState {
  @override
  List<Object?> get props => [];
}

class SearchIdleSuccess extends SearchIdleState {
  final MovieCollection collection;
  final bool isReloading;

  const SearchIdleSuccess({
    required this.collection,
    this.isReloading = false,
  });

  @override
  List<Object?> get props => [collection, isReloading];
}

class SearchIdleError extends SearchIdleState {
  final AppFailure error;

  const SearchIdleError(this.error);

  @override
  List<Object?> get props => [error];
}

class SearchIdleLoading extends SearchIdleState {
  @override
  List<Object?> get props => [];
}

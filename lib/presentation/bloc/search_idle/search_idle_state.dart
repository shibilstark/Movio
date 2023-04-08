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
  final int timeStamp;

  const SearchIdleSuccess({
    required this.collection,
    this.isReloading = false,
    required this.timeStamp,
  });

  @override
  List<Object?> get props => [collection, isReloading, timeStamp];
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

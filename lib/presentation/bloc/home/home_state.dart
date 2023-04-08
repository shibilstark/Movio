// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeSuccess extends HomeState {
  final List<MovieCollectionWithType> allCollections;

  final int timeStamp;

  const HomeSuccess({
    required this.allCollections,
    required this.timeStamp,
  });

  @override
  List<Object> get props => [allCollections, timeStamp];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeError extends HomeState {
  final AppFailure error;

  const HomeError(this.error);
  @override
  List<Object> get props => [error];
}

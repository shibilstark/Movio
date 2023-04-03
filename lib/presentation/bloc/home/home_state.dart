part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  // final Either<MovieCollection, AppFailure>? upcomingCollection;
  // final Either<MovieCollection, AppFailure>? topRatedCollection;
  // final Either<MovieCollection, AppFailure>? nowPlayingCollection;
  // final Either<MovieCollection, AppFailure>? popularCollection;
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {}

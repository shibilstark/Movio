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
  // final Either<MovieCollection, AppFailure>? upcomingCollection;
  // final Either<MovieCollection, AppFailure>? topRatedCollection;
  // final Either<MovieCollection, AppFailure>? nowPlayingCollection;
  // final Either<MovieCollection, AppFailure>? popularCollection;
  // final Either<MovieCollection, AppFailure>? trendingsCollection;

  final Map<MovieCollectionType, Either<MovieCollection, AppFailure>?>
      collectionMap;

  const HomeSuccess({
    required this.collectionMap,
  });

  @override
  List<Object> get props => [
        // upcomingCollection ?? const Uuid().v4(),
        // topRatedCollection ?? const Uuid().v4(),
        // trendingsCollection ?? const Uuid().v4(),
        // nowPlayingCollection ?? const Uuid().v4(),
        // popularCollection ?? const Uuid().v4(),
      ];

  // HomeSuccess copyWith({
  //   Either<MovieCollection, AppFailure>? upcomingCollection,
  //   Either<MovieCollection, AppFailure>? topRatedCollection,
  //   Either<MovieCollection, AppFailure>? nowPlayingCollection,
  //   Either<MovieCollection, AppFailure>? popularCollection,
  //   Either<MovieCollection, AppFailure>? trendingsCollection,
  // }) {
  //   return HomeSuccess(
  //     upcomingCollection: upcomingCollection ?? this.upcomingCollection,
  //     topRatedCollection: topRatedCollection ?? this.topRatedCollection,
  //     nowPlayingCollection: nowPlayingCollection ?? this.nowPlayingCollection,
  //     popularCollection: popularCollection ?? this.popularCollection,
  //     trendingsCollection: trendingsCollection ?? this.trendingsCollection,
  //   );
  // }
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

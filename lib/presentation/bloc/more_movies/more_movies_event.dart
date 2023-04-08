part of 'more_movies_bloc.dart';

abstract class MoreMoviesEvent implements Equatable {
  const MoreMoviesEvent();

  @override
  List<Object> get props => [];
}

class GetCollection implements MoreMoviesEvent {
  final MovieCollectionType type;
  const GetCollection(this.type);

  @override
  List<Object> get props => [type];

  @override
  bool? get stringify => true;
}

class ReLoadCollection implements MoreMoviesEvent {
  final MovieCollectionType type;
  const ReLoadCollection(this.type);

  @override
  List<Object> get props => [type];

  @override
  bool? get stringify => true;
}

class GetSimilarMovies implements MoreMoviesEvent {
  final int movieId;
  const GetSimilarMovies(this.movieId);

  @override
  List<Object> get props => [movieId];

  @override
  bool? get stringify => true;
}

class ReLoadSimilarMovies implements MoreMoviesEvent {
  final int movieId;
  const ReLoadSimilarMovies(this.movieId);

  @override
  List<Object> get props => [movieId];

  @override
  bool? get stringify => true;
}

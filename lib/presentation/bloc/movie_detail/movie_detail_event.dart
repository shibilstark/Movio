part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadMovieDetails extends MovieDetailEvent {
  final int movieId;

  const LoadMovieDetails(this.movieId);

  @override
  List<Object> get props => [movieId];
}

class LoadMovieImages extends MovieDetailEvent {
  final int movieId;

  const LoadMovieImages(this.movieId);

  @override
  List<Object> get props => [movieId];
}

// class LoadSimilarMovies extends MovieDetailEvent {
//   final int movieId;

//   const LoadSimilarMovies(this.movieId);

//   @override
//   List<Object> get props => [movieId];
// }

// class ReloadSimilarMovies extends MovieDetailEvent {
//   const ReloadSimilarMovies();

//   @override
//   List<Object> get props => [];
// }

part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchEvent extends Equatable {}

class SearchMovie extends MovieSearchEvent {
  final String query;

  SearchMovie(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadNewResults extends MovieSearchEvent {
  final String query;

  LoadNewResults({
    required this.query,
  });

  @override
  List<Object?> get props => [query];
}

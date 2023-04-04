part of 'movie_search_bloc.dart';

@immutable
abstract class MovieSearchEvent extends Equatable {}

class SearchMovie extends MovieSearchEvent {
  final String query;

  SearchMovie(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadNewPage extends MovieSearchEvent {
  final String query;
  final int page;

  LoadNewPage({
    required this.query,
    required this.page,
  });

  @override
  List<Object?> get props => [page, query];
}

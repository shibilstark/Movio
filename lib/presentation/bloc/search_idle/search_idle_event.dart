part of 'search_idle_bloc.dart';

abstract class SearchIdleEvent extends Equatable {
  const SearchIdleEvent();

  @override
  List<Object> get props => [];
}

class LoadIdle extends SearchIdleEvent {}

class LoadNewPage extends SearchIdleEvent {
  final int page;
  const LoadNewPage(this.page);

  @override
  List<Object> get props => [page];
}

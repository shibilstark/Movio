part of 'search_idle_bloc.dart';

abstract class SearchIdleEvent extends Equatable {
  const SearchIdleEvent();

  @override
  List<Object> get props => [];
}

class LoadIdle extends SearchIdleEvent {}

class LoadNewPage extends SearchIdleEvent {
  const LoadNewPage();

  @override
  List<Object> get props => [];
}

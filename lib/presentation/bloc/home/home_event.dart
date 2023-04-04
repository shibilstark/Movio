part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadCollections extends HomeEvent {
  const LoadCollections();

  @override
  List<Object> get props => [];
}

class ReloadSingleCollection extends HomeEvent {
  final MovieCollectionType type;
  const ReloadSingleCollection(this.type);

  @override
  List<Object> get props => [type];
}

part of 'locations_cubit.dart';

@immutable
sealed class LocationsState {}

final class InitialLocationsState extends LocationsState {}

final class LoadingLocationsState extends LocationsState {}

final class SuccessLocationsState extends LocationsState {
  final VideoModel result;

  SuccessLocationsState({required this.result});
}

final class ErrorLocationsState extends LocationsState {
  final String errorMessage;

  ErrorLocationsState({required this.errorMessage});
}

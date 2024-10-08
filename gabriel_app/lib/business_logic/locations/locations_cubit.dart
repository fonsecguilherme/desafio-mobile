import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/repository/gabriel_repository.dart';
import '../../data/models/video_model.dart';

part 'locations_state.dart';

class LocationsCubit extends Cubit<LocationsState> {
  LocationsCubit({required this.repository}) : super(InitialLocationsState());

  final IGabrielRepository repository;

  Future<void> getLocations({String size = '10'}) async {
    emit(LoadingLocationsState());

    try {
      final result = await repository.getAllLocations(size: size);

      if (result != null) {
        emit(SuccessLocationsState(result: result));
      }
    } catch (e) {
      emit(
        ErrorLocationsState(errorMessage: e.toString()),
      );
    }
  }
}

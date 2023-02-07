import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/data/repository/location_repository.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_state.dart';
import 'package:deprem_destek/shared/state/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class DemandsCubit extends Cubit<DemandsState> {
  DemandsCubit({
    required LocationRepository locationRepository,
    required DemandsRepository demandsRepository,
  })  : _demandsRepository = demandsRepository,
        _locationRepository = locationRepository,
        super(const DemandsState.loading()) {
    getDemands(first: true);
  }

  final LocationRepository _locationRepository;
  final DemandsRepository _demandsRepository;
  final ScrollController scrollController = ScrollController();
  GoogleGeocodingResult? position;
  double radius = 1;
  int page = 1;

  Future<void> getDemands({
    bool reloadPage = false,
    bool first = false,
  }) async {
    if (first == true || state == const DemandsState.loaded()) {
      emit(const DemandsState.loading());
      position = position ?? (await _locationRepository.getLocation());
      if (reloadPage) page = 1;
      final location = position?.geometry?.location;
      if (location != null) {
        final demands = await _demandsRepository.getDemands(
          geo: GeoPoint(location.lat, location.lng),
          radius: radius, // TODO: Radius max değer aldığında null gönderilecek
          categoryUUIDs: [],
          page: page,
        );
        emit(DemandsState.loaded(demands: demands));
        page += 1;
      } else {
        emit(const DemandsState.failed());
      }
    }
  }

  void radiusChanged(double value) {
    radius = value;
    if (state is loadedAppState) {
      emit(
        DemandsState.loaded(
          radius: radius,
          showFilter: (state as loadedAppState).showFilter,
          demands: (state as loadedAppState).demands,
        ),
      );
    }
  }

  void changeFilterVisibility({required bool showFilter}) {
    emit(DemandsState.loaded(showFilter: !showFilter));
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}

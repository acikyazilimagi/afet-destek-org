import 'dart:async';

import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/pages/demands_page/state/demands_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class DemandsCubit extends Cubit<DemandsState> {
  DemandsCubit({
    required DemandsRepository demandsRepository,
    required GoogleGeocodingLocation currentLocation,
  })  : _demandsRepository = demandsRepository,
        _currentLocation = currentLocation,
        super(
          const DemandsState(
            categoryIds: null,
            demands: null,
            filterRadiusKm: null,
            status: DemandsStateStatus.loading(),
          ),
        ) {
    getDemands();
  }
  final GoogleGeocodingLocation _currentLocation;
  final DemandsRepository _demandsRepository;

  int _page = 1;

  Future<void> getDemands() async {
    try {
      emit(state.copyWith(status: const DemandsStateStatus.loading()));

      final demands = await _demandsRepository.getDemands(
        page: _page,
        geo: _currentLocation,
        categoryIds: state.categoryIds,
        radius: state.filterRadiusKm,
      );

      emit(
        state.copyWith(
          demands: demands,
          status: const DemandsStateStatus.loaded(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: const DemandsStateStatus.failure()));
    }
  }

  Future<void> setCategoryIds({required List<String>? categoryIds}) async {
    emit(state.copyWith(categoryIds: categoryIds));
    unawaited(getDemands());
  }

  Future<void> setfilterRadiusKm({required double filterRadiusKm}) async {
    emit(state.copyWith(filterRadiusKm: filterRadiusKm));
    unawaited(getDemands());
  }

  Future<void> increasePage() async {
    _page++;
    unawaited(getDemands());
  }
}

import 'dart:async';

import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/pages/demands_page/state/demands_state.dart';
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
  bool _isLastPage = false;

  Future<void> getDemands({bool shouldClearDemands = false}) async {
    try {
      if (shouldClearDemands) {
        emit(
          state.copyWith(
            demands: null,
            status: const DemandsStateStatus.loading(),
          ),
        );
      } else {
        emit(state.copyWith(status: const DemandsStateStatus.loading()));
      }

      final demands = await _demandsRepository.getDemands(
        page: _page,
        geo: _currentLocation,
        categoryIds: state.categoryIds,
        radius: state.filterRadiusKm,
      );
      _isLastPage = demands.isEmpty;
      emit(
        state.copyWith(
          demands: [...state.demands ?? [], ...demands],
          status: const DemandsStateStatus.loaded(),
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: const DemandsStateStatus.failure()));
    }
  }

  Future<void> setFilters({
    required List<String>? categoryIds,
    required double? filterRadiusKm,
  }) async {
    _page = 1;
    emit(
      state.copyWith(
        categoryIds: categoryIds,
        filterRadiusKm: filterRadiusKm,
        demands: null,
      ),
    );

    unawaited(getDemands());
  }

  Future<void> loadNextPage() async {
    state.status.maybeWhen(
      loading: () => null,
      orElse: () {
        if (!_isLastPage) {
          _page++;
          unawaited(getDemands());
        }
      },
    );
  }
}

import 'dart:async';

import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/pages/demands_page/state/demands_state.dart';
import 'package:afet_destek/shared/extensions/hive_extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:hive_flutter/adapters.dart';

class DemandsCubit extends Cubit<DemandsState> {
  DemandsCubit({
    required DemandsRepository demandsRepository,
    required GoogleGeocodingLocation currentLocation,
  })  : _demandsRepository = demandsRepository,
        _currentLocation = currentLocation,
        super(
          DemandsState(
            demands: null,
            status: const DemandsStateStatus.loading(),
          ),
        ) {
    initFilterState();
    getDemands();
  }
  final GoogleGeocodingLocation _currentLocation;
  final DemandsRepository _demandsRepository;

  int _page = 1;
  bool _isLastPage = false;

  Box<DemandsStateFilter>? _box;

  Future<void> _openBox() async {
    DemandsStateFilterAdapter().register();

    _box ??= await Hive.openBox<DemandsStateFilter>('demands_filter');
  }

  Future<void> initFilterState() async {
    emit(state.copyWith(status: const DemandsStateStatus.loading()));

    await _openBox();

    final savedFilter =
        _box!.isEmpty ? DemandsStateFilter.empty() : _box!.getAt(0);

    emit(
      state.copyWith(
        filter: savedFilter,
        status: const DemandsStateStatus.loaded(),
      ),
    );
  }

  Future<void> getDemands() async {
    try {
      emit(state.copyWith(status: const DemandsStateStatus.loading()));

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

  Future<void> refreshDemands() async {
    try {
      _page = 1;
      emit(
        state.copyWith(
          filter: DemandsStateFilter.empty(),
          demands: null,
          status: const DemandsStateStatus.loading(),
        ),
      );
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

    await _openBox();
    emit(
      state.copyWith(
        filter: DemandsStateFilter(
          categoryIds: categoryIds,
          filterRadiusKm: filterRadiusKm,
        ),
        demands: null,
      ),
    );

    unawaited(
      _box!.isEmpty ? _box!.add(state.filter!) : _box!.putAt(0, state.filter!),
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

import 'dart:async';
import 'dart:convert';

import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/pages/demands_page/state/demands_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DemandsCubit extends Cubit<DemandsState> {
  DemandsCubit({
    required DemandsRepository demandsRepository,
    required GoogleGeocodingLocation currentLocation,
  })  : _demandsRepository = demandsRepository,
        _currentLocation = currentLocation,
        super(
          const DemandsState(
            demands: null,
            status: DemandsStateStatus.loading(),
          ),
        ) {
    init();
  }
  final GoogleGeocodingLocation _currentLocation;
  final DemandsRepository _demandsRepository;

  int _page = 1;
  bool _isLastPage = false;

  SharedPreferences? _prefss;
  FutureOr<SharedPreferences> get prefs async =>
      _prefss ??= await SharedPreferences.getInstance();

  static const String _filterKey = 'filterKey';

  Future<void> init() async {
    emit(state.copyWith(status: const DemandsStateStatus.loading()));

    try {
      final savedFilterStr = (await prefs).getString(_filterKey);

      if (savedFilterStr != null && savedFilterStr.isNotEmpty) {
        final savedFilterJson = json.decode(savedFilterStr);
        final savedFilter = DemandsStateFilter.fromJson(
          savedFilterJson as Map<String, dynamic>,
        );

        emit(
          state.copyWith(
            filter: savedFilter,
          ),
        );
      }
    } catch (_) {}

    await getDemands();
  }

  Future<void> getDemands() async {
    try {
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
      (await prefs).setString(
        _filterKey,
        json.encode(
          state.filter.toJson(),
        ),
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

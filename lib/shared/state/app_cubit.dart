import 'dart:async';

import 'package:afet_destek/data/repository/demands_repository.dart';
import 'package:afet_destek/data/repository/location_repository.dart';
import 'package:afet_destek/shared/state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _welcomePageKey = 'welcomePageKey';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required LocationRepository locationRepository,
    required DemandsRepository demandsRepository,
  })  : _demandsRepository = demandsRepository,
        _locationRepository = locationRepository,
        super(const AppState.initializing()) {
    init();
  }
  final LocationRepository _locationRepository;
  final DemandsRepository _demandsRepository;

  Future<void> init() async {
    try {
      final sprefs = await SharedPreferences.getInstance();

      final isShown = sprefs.getBool(_welcomePageKey);

      if (isShown == null) {
        emit(const AppState.introduction());
      } else {
        unawaited(startApp());
      }
    } catch (_) {
      unawaited(startApp());
    }
  }

  Future<void> startApp() async {
    try {
      final sprefs = await SharedPreferences.getInstance();

      unawaited(sprefs.setBool(_welcomePageKey, true));

      emit(const AppState.loading());

      final geoLocation = await _locationRepository
          .getLocation()
          .timeout(const Duration(seconds: 10));

      final demandCategories = await _demandsRepository
          .getDemandCategories()
          .timeout(const Duration(seconds: 10));

      emit(
        AppState.loaded(
          currentLocation: geoLocation,
          demandCategories: demandCategories,
        ),
      );
    } catch (_) {
      emit(const AppState.failed());
    }
  }
}

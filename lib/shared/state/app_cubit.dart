import 'package:deprem_destek/data/repository/demands_repository.dart';
import 'package:deprem_destek/data/repository/location_repository.dart';
import 'package:deprem_destek/shared/state/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required LocationRepository locationRepository,
    required DemandsRepository demandsRepository,
  })  : _demandsRepository = demandsRepository,
        _locationRepository = locationRepository,
        super(const AppState.introduction());
  final LocationRepository _locationRepository;
  final DemandsRepository _demandsRepository;
  Future<void> startApp() async {
    try {
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

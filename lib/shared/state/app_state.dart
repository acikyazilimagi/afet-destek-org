import 'package:afet_destek/data/models/demand_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.initializing() = _initializingAppState;
  const factory AppState.introduction() = _introductionAppState;
  const factory AppState.loading() = _loadingAppState;
  const factory AppState.loaded({
    required GoogleGeocodingResult currentLocation,
    required List<DemandCategory> demandCategories,
  }) = _loadedAppState;
  const factory AppState.failed() = _failedAppState;
}

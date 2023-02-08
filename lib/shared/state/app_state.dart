import 'package:deprem_destek/data/models/demand_category.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

part 'app_state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState.introduction() = _introductionAppState;
  const factory AppState.loading() = _loadingAppState;
  const factory AppState.loaded({
    required GoogleGeocodingResult currentLocation,
    required List<DemandCategory> demandCategories,
  }) = _loadedAppState;
  const factory AppState.failed() = _failedAppState;

  /*  when({required IntroductionPage Function() introduction, required DemandsPage Function(dynamic _, dynamic __) loaded, required AppLoadFailurePage Function() failed, required Scaffold Function() loading}) {} */
}

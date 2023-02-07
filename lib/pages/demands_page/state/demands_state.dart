import 'package:deprem_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demands_state.freezed.dart';

@freezed
class DemandsState with _$DemandsState {
  const factory DemandsState.loading() = _loadingDemandState;
  const factory DemandsState.loaded({
    List<Demand>? demands,
    bool? showFilter,
    double? radius,
  }) = loadedAppState;
  const factory DemandsState.failed() = _failedAppState;
}

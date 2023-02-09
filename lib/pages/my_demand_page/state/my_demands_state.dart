import 'package:afet_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_demands_state.freezed.dart';

@freezed
class MyDemandState with _$MyDemandState {
  const factory MyDemandState({
    required MyDemandStateStatus status,
    required Demand? demand,
  }) = _MyDemandState;
}

@freezed
class MyDemandStateStatus with _$MyDemandStateStatus {
  const factory MyDemandStateStatus.loadingCurrentDemand() =
      _loadingCurrentDemand;
  const factory MyDemandStateStatus.loadFailed() = _loadFailed;

  const factory MyDemandStateStatus.loadedCurrentDemand() =
      _loadedCurrentDemand;
  const factory MyDemandStateStatus.saving() = _saving;
  const factory MyDemandStateStatus.saveSuccess() = _saveSuccess;
  const factory MyDemandStateStatus.saveFail() = _saveFail;
}

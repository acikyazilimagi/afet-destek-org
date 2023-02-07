import 'package:deprem_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_demands_state.freezed.dart';

@freezed
class MyDemandState with _$MyDemandState {
  const factory MyDemandState({
    required MyDemandStateStatus status,
    required Demand? demand,
  }) = _MyDemandState;
}

enum MyDemandStateStatus {
  loadingCurrentDemand,
  loadFailed,
  loadedCurrentDemand,
  saving,
  saveSuccess,
  saveFail,
}

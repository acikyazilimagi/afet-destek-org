import 'package:deprem_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_demands_state.freezed.dart';

@freezed
class MyDemandState with _$MyDemandState {
  const factory MyDemandState.loading() = _loadingMyDemandState;
  const factory MyDemandState.loaded({
    required bool loading,
    required Demand? demand,
  }) = _loadedMyDemandState;
  const factory MyDemandState.failed() = _failedMyDemandState;
}

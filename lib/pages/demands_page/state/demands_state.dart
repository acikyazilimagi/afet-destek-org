import 'package:deprem_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demands_state.freezed.dart';

@freezed
class DemandsState with _$DemandsState {
  const factory DemandsState({
    required DemandsStateStatus status,
    required List<Demand>? demands,
    required List<String>? categoryIds,
    required double? filterRadiusKm,
  }) = _DemandsState;
  const DemandsState._();

  bool get hasAnyFilter => categoryIds != null || filterRadiusKm != null;
}

@freezed
class DemandsStateStatus with _$DemandsStateStatus {
  const factory DemandsStateStatus.loading() = _loading;
  const factory DemandsStateStatus.loaded() = _loaded;
  const factory DemandsStateStatus.failure() = _failure;
}

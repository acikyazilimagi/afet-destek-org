import 'package:afet_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/adapters.dart';

part 'demands_state.g.dart';
part 'demands_state.freezed.dart';

@freezed
class DemandsState with _$DemandsState {
  factory DemandsState({
    required DemandsStateStatus status,
    required List<Demand>? demands,
    DemandsStateFilter? filter,
  }) = _DemandsState;
  DemandsState._();

  List<String>? get categoryIds => filter?.categoryIds;
  double? get filterRadiusKm => filter?.filterRadiusKm;

  bool get hasAnyFilters => categoryIds != null || filterRadiusKm != null;
}

@freezed
@HiveType(typeId: 0)
class DemandsStateFilter extends HiveObject with _$DemandsStateFilter {
  factory DemandsStateFilter({
    @HiveField(0) required List<String>? categoryIds,
    @HiveField(1) required double? filterRadiusKm,
  }) = _DemandsStateFilter;
  DemandsStateFilter._();

  factory DemandsStateFilter.empty() => DemandsStateFilter(
        categoryIds: null,
        filterRadiusKm: null,
      );
}

@freezed
class DemandsStateStatus with _$DemandsStateStatus {
  const factory DemandsStateStatus.loading() = _loading;
  const factory DemandsStateStatus.loaded() = _loaded;
  const factory DemandsStateStatus.failure() = _failure;
}

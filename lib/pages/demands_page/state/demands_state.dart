import 'package:afet_destek/data/models/demand.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demands_state.g.dart';
part 'demands_state.freezed.dart';

@freezed
class DemandsState with _$DemandsState {
  const factory DemandsState({
    required DemandsStateStatus status,
    required List<Demand>? demands,
    @Default(
      DemandsStateFilter(
        categoryIds: null,
        filterRadiusKm: null,
      ),
    )
        DemandsStateFilter filter,
  }) = _DemandsState;
  const DemandsState._();

  List<String>? get categoryIds => filter.categoryIds;
  double? get filterRadiusKm => filter.filterRadiusKm;

  bool get hasAnyFilters => categoryIds != null || filterRadiusKm != null;
}

@freezed
class DemandsStateFilter with _$DemandsStateFilter {
  const factory DemandsStateFilter({
    required List<String>? categoryIds,
    required double? filterRadiusKm,
  }) = _DemandsStateFilter;
  const DemandsStateFilter._();

  factory DemandsStateFilter.fromJson(Map<String, dynamic> json) =>
      _$DemandsStateFilterFromJson(json);
}

@freezed
class DemandsStateStatus with _$DemandsStateStatus {
  const factory DemandsStateStatus.loading() = _loading;
  const factory DemandsStateStatus.loaded() = _loaded;
  const factory DemandsStateStatus.failure() = _failure;
}

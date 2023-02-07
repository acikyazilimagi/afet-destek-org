import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demand_category.freezed.dart';
part 'demand_category.g.dart';

@freezed
class DemandCategory with _$DemandCategory {
  const factory DemandCategory({
    required String id,
    required String name,
  }) = _DemandCategory;

  factory DemandCategory.fromJson(Map<String, dynamic> json) =>
      _$DemandCategoryFromJson(json);
}

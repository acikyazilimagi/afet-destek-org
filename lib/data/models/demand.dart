import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:flutter/foundation.dart';

part 'demand.freezed.dart';
part 'demand.g.dart';

@freezed
class Demand with _$Demand {
  const factory Demand({
    required String id,
    required String userId,
    required List<String> categoryIds,
    required GeoFirePoint geo,
    required String notes,
    required String phoneNumber,
    required bool isActive,
  }) = _Demand;

  factory Demand.fromJson(Map<String, dynamic> json) => _$DemandFromJson(json);
}

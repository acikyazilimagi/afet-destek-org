import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

part 'demand.freezed.dart';
part 'demand.g.dart';

@freezed
class Demand with _$Demand {
  const factory Demand({
    required String id,
    required String userId,
    required List<String> categoryIds,
    @JsonKey(
      fromJson: _DemandJsonParsers.geoFromJson,
      toJson: _DemandJsonParsers.geoToJson,
    )
        required GeoFirePoint geo,
    required String notes,
    required String phoneNumber,
    required bool isActive,
  }) = _Demand;

  factory Demand.fromJson(Map<String, dynamic> json) => _$DemandFromJson(json);
}

abstract class _DemandJsonParsers {
  static Map<String, dynamic> geoToJson(GeoFirePoint geoFirePoint) {
    return {'lat': geoFirePoint.latitude, 'long': geoFirePoint.longitude};
  }

  static GeoFirePoint geoFromJson(Map<String, dynamic> json) {
    return GeoFirePoint(json['lat'] as double, json['long'] as double);
  }
}

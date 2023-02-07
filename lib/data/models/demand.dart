import 'package:cloud_firestore/cloud_firestore.dart';
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
    required String addressText,
    required String phoneNumber,
    required bool isActive,
  }) = _Demand;

  factory Demand.fromJson(Map<String, dynamic> json) => _$DemandFromJson(json);
}

abstract class _DemandJsonParsers {
  static Map<String, dynamic> geoToJson(GeoFirePoint geoFirePoint) {
    return geoFirePoint.data as Map<String, dynamic>;
  }

  static GeoFirePoint geoFromJson(Map<String, dynamic> json) {
    final geoPoint = json['geopoint'] as GeoPoint;

    return GeoFirePoint(
      geoPoint.latitude,
      geoPoint.longitude,
    );
  }
}

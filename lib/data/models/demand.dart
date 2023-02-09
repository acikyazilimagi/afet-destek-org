import 'package:afet_destek/data/models/demand_category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'demand.freezed.dart';
part 'demand.g.dart';

@freezed
class Demand with _$Demand {
  const factory Demand({
    required String id,
    required String userId,
    required List<String> categoryIds,
    required String notes,
    required String addressText,
    required String phoneNumber,
    required String? whatsappNumber,
    required DateTime modifiedTimeUtc,
    required bool isActive,
    required int distanceMeter,
  }) = _Demand;

  const Demand._();

  factory Demand.fromJson(Map<String, dynamic> json) => _$DemandFromJson(json);

  factory Demand.fromFirebaseJson(Map<String, dynamic> json) {
    final time = json.remove('updatedTime') as Timestamp;
    json['modifiedTimeUtc'] =
        DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch)
            .toIso8601String();

    json['distanceMeter'] = -1;
    return _$DemandFromJson(json);
  }
  List<String> categoryNames({required List<DemandCategory> demandCategories}) {
    return categoryIds
        .map(
          (id) =>
              demandCategories
                  .firstWhereOrNull(
                    (category) => category.id == id,
                  )
                  ?.name ??
              '-',
        )
        .toList();
  }
}

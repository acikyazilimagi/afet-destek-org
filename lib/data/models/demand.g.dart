// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Demand _$$_DemandFromJson(Map<String, dynamic> json) => _$_Demand(
      id: json['id'] as String,
      userId: json['userId'] as String,
      categoryIds: (json['categoryIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      geo: _DemandJsonParsers.geoFromJson(json['geo'] as Map<String, dynamic>),
      notes: json['notes'] as String,
      phoneNumber: json['phoneNumber'] as String,
      isActive: json['isActive'] as bool,
    );

Map<String, dynamic> _$$_DemandToJson(_$_Demand instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'categoryIds': instance.categoryIds,
      'geo': _DemandJsonParsers.geoToJson(instance.geo),
      'notes': instance.notes,
      'phoneNumber': instance.phoneNumber,
      'isActive': instance.isActive,
    };

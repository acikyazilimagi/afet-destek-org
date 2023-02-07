import 'package:geoflutterfire2/geoflutterfire2.dart';

class Demand {
  const Demand({
    required this.id,
    required this.userId,
    required this.categoryIds,
    required this.geo,
    required this.notes,
    required this.phoneNumber,
    required this.isActive,
  });

  factory Demand.fromMap(Map<String, dynamic> data, String documentId) {
    if (data.isEmpty) {
      throw Exception('Data is empty');
    }

    final categoryIds = List<String>.from(data['categoryIds'] as List<dynamic>);
    final geo = data['geo'] as GeoFirePoint;
    final notes = data['notes'] as String;
    final phoneNumber = data['phoneNumber'] as String;
    final isActive = data['isActive'] as bool;

    return Demand(
      id: documentId,
      userId: data['userId'] as String,
      categoryIds: categoryIds,
      geo: geo,
      notes: notes,
      phoneNumber: phoneNumber,
      isActive: isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'categoryIds': categoryIds,
      'geo': geo,
      'notes': notes,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
    };
  }

  final String id;
  final String userId;
  final List<String> categoryIds;
  final GeoFirePoint geo;
  final String notes;
  final String phoneNumber;
  final bool isActive;
}

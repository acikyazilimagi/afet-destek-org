class DemandCategory {
  const DemandCategory({
    required this.id,
    required this.name,
  });

  factory DemandCategory.fromMap(Map<String, dynamic> data, String documentId) {
    if (data.isEmpty) {
      throw Exception('Data is empty');
    }

    return DemandCategory(
      id: documentId,
      name: data['name'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  final String id;
  final String name;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/models/demand_category.dart';

class DemandRepository {
  final _collection = FirebaseFirestore.instance.collection('demand_categories');

  Future<List<DemandCategory>> getDemandCategories() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      return DemandCategory.fromMap(doc.data(), doc.id);
    }).toList();
  }
}

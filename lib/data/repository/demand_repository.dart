import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/models/demand.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class DemandRepository {
  final _geoFlutterFire = GeoFlutterFire();
  final _collection = FirebaseFirestore.instance.collection('demands');

  Future<void> addDemand({
    required String userId,
    required List<String> categories,
    required GeoPoint geo,
    required String notes,
    required String phoneNumber,
    required bool isActive,
  }) async {
    await _collection.add({
      'userId': userId,
      'categories': categories,
      'geo': geo,
      'notes': notes,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
    });
  }

  Future<void> updateDemandById({
    required String id,
    required String userId,
    required List<String> categories,
    required GeoPoint geo,
    required String notes,
    required String phoneNumber,
    required bool isActive,
  }) async {
    final location = _geoFlutterFire.point(
      latitude: geo.latitude,
      longitude: geo.longitude,
    );

    await _collection.doc(id).update({
      'userId': userId,
      'categories': categories,
      'geo': location,
      'notes': notes,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
    });
  }

  Future<void> deleteDemandById(String id) async {
    await _collection.doc(id).delete();
  }

  Future<Demand> getDemandById(String id) async {
    final doc = await _collection.doc(id).get();
    return Demand.fromMap(doc.data()!, doc.id);
  }

  Future<List<Demand>> getDemands() async {
    final snapshot = await _collection.get();
    return snapshot.docs.map((doc) {
      return Demand.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Future<List<Demand>> getDemandsByUserId(String userId) async {
    final snapshot = await _collection.where('userId', isEqualTo: userId).get();
    return snapshot.docs.map((doc) {
      return Demand.fromMap(doc.data(), doc.id);
    }).toList();
  }

  Stream<List<Demand>> getDemandsByLocationStream({
    required GeoPoint geo,
    required double radius,
  }) {
    final center = _geoFlutterFire.point(
      latitude: geo.latitude,
      longitude: geo.longitude,
    );

    return _geoFlutterFire
        .collection(collectionRef: _collection)
        .within(
          center: center,
          radius: radius,
          field: 'geo',
        )
        .map(
          (event) => event
              .map(
                (e) => e.data() != null
                    ? Demand.fromMap(
                        e.data() as Map<String, dynamic>,
                        e.id,
                      )
                    : null,
              )
              .where((element) => element != null)
              .toList() as List<Demand>,
        );
  }

  Stream<List<Demand>> getDemandsStream() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Demand.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<Demand>> getDemandsByUserIdStream(String userId) {
    return _collection.where('userId', isEqualTo: userId).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Demand.fromMap(doc.data(), doc.id);
        }).toList();
      },
    );
  }
}

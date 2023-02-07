import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/models/demand.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class DemandRepository {
  final _geoFlutterFire = GeoFlutterFire();
  final _collection = FirebaseFirestore.instance.collection('demands');
  final _auth = FirebaseAuth.instance;

  Future<void> addDemand({
    required List<String> categories,
    required GeoPoint geo,
    required String notes,
    required String phoneNumber,
    required bool isActive,
  }) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    final location = _geoFlutterFire.point(
      latitude: geo.latitude,
      longitude: geo.longitude,
    );

    await _collection.add({
      'userId': _auth.currentUser!.uid,
      'categories': categories,
      'geo': location,
      'notes': notes,
      'phoneNumber': phoneNumber,
      'isActive': isActive,
    });
  }

  Future<void> activateCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    await _collection.doc(_auth.currentUser!.uid).update({
      'isActive': true,
    });
  }

  Future<void> deactivateCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    await _collection.doc(_auth.currentUser!.uid).update({
      'isActive': false,
    });
  }

  Future<void> deleteCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    await _collection.doc(_auth.currentUser!.uid).delete();
  }

  Future<Demand> getCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    final doc = await _collection.doc(_auth.currentUser!.uid).get();
    return Demand.fromMap(doc.data()!, doc.id);
  }

  Future<List<Demand>> getDemands({
    required GeoPoint geo,
    required double radius,
  }) async {
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
        .asyncMap(
          (event) => event
              .map(
                (e) => Demand.fromMap(
                  e.data() as Map<String, dynamic>,
                  e.id,
                ),
              )
              .toList(),
        )
        .first;
  }
}

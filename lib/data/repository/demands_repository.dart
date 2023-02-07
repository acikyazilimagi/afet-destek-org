import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deprem_destek/data/models/demand.dart';
import 'package:deprem_destek/data/models/demand_category.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';

class DemandsRepository {
  final _geoFlutterFire = GeoFlutterFire();
  final _demandsCollection = FirebaseFirestore.instance.collection('demands');
  final _demandCategoriesCollection =
      FirebaseFirestore.instance.collection('demand_categories');
  final _auth = FirebaseAuth.instance;

  Future<List<DemandCategory>> getDemandCategories() async {
    final snapshot = await _demandCategoriesCollection.get();
    return snapshot.docs.map((doc) {
      return DemandCategory.fromJson(doc.data());
    }).toList();
  }

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

    await _demandsCollection.add({
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

    await _demandsCollection.doc(_auth.currentUser!.uid).update({
      'isActive': true,
    });
  }

  Future<void> deactivateCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    await _demandsCollection.doc(_auth.currentUser!.uid).update({
      'isActive': false,
    });
  }

  Future<Demand> getCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    final doc = await _demandsCollection.doc(_auth.currentUser!.uid).get();
    return Demand.fromJson(doc.data()!);
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
        .collection(collectionRef: _demandsCollection)
        .within(
          center: center,
          radius: radius,
          field: 'geo',
        )
        .map(
          (event) => event
              .map(
                (e) => Demand.fromJson(e.data()! as Map<String, dynamic>),
              )
              .toList(),
        )
        .first;
  }
}

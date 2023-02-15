import 'package:afet_destek/app_func.dart';
import 'package:afet_destek/data/api/demands_api_client.dart';
import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/data/models/demand_category.dart';
import 'package:afet_destek/shared/extensions/district_address_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class DemandsRepository {
  DemandsRepository({required DemandsApiClient demandsApiClient})
      : _demandsApiClient = demandsApiClient;

  final DemandsApiClient _demandsApiClient;
  final _demandsCollection = FirebaseFirestore.instance.collection('demands');
  final _notificationsCollection =
      FirebaseFirestore.instance.collection('notifications');
  final _demandCategoriesCollection =
      FirebaseFirestore.instance.collection('demand_categories');
  final _auth = FirebaseAuth.instance;

  Future<List<DemandCategory>> getDemandCategories() async {
    final snapshot = await _demandCategoriesCollection.get();
    return snapshot.docs.map((doc) {
      return DemandCategory.fromJson({
        'id': doc.id,
        ...doc.data(),
      });
    }).toList();
  }

  Future<void> subscribeToDemands({
    required GoogleGeocodingResult geo,
    required List<String> categoryIds,
    required double radiusKm,
  }) async {
    await FirebaseMessaging.instance.requestPermission();

    final fcmToken = await FirebaseMessaging.instance.getToken(
      vapidKey: AppFunc.vapidKey,
    );

    await _notificationsCollection.add({
      'locale': 'tr_TR',
      'geo': GeoPoint(geo.geometry!.location.lat, geo.geometry!.location.lng),
      'categoryIds': FieldValue.arrayUnion(categoryIds),
      'fcmToken': fcmToken,
      'createdTime': FieldValue.serverTimestamp(),
      'radiusKm': radiusKm < 50 ? radiusKm.toInt() : -1,
    }).timeout(const Duration(seconds: 3));
  }

  Future<void> addDemand({
    required GoogleGeocodingResult geo,
    required List<String> categoryIds,
    required String notes,
    required String phoneNumber,
    required String? whatsappNumber,
  }) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    await _demandsCollection.add({
      'userId': _auth.currentUser!.uid,
      'geo': GeoPoint(geo.geometry!.location.lat, geo.geometry!.location.lng),
      'notes': notes,
      'addressText': geo.districtAddress,
      'fullAddressText': geo.formattedAddress,
      'categoryIds': FieldValue.arrayUnion(categoryIds),
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'isActive': true,
      'createdTime': FieldValue.serverTimestamp(),
      'updatedTime': FieldValue.serverTimestamp()
    }).timeout(const Duration(seconds: 3));
  }

  Future<void> updateDemand({
    required String demandId,
    GoogleGeocodingResult? geo,
    required List<String> categoryIds,
    required String notes,
    required String phoneNumber,
    required String? whatsappNumber,
  }) async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    await _demandsCollection.doc(demandId).update({
      'notes': notes,
      'categoryIds': categoryIds,
      'phoneNumber': phoneNumber,
      'whatsappNumber': whatsappNumber,
      'updatedTime': FieldValue.serverTimestamp(),
      if (geo != null) ...{
        'geo': GeoPoint(geo.geometry!.location.lat, geo.geometry!.location.lng),
        'addressText': geo.districtAddress,
        'fullAddressText': geo.formattedAddress,
      }
    }).timeout(const Duration(seconds: 3));
  }

  Future<void> activateDemand({required String demandId}) async {
    await _demandsCollection.doc(demandId).update({
      'isActive': true,
    });
  }

  Future<void> deactivateDemand({required String demandId}) async {
    await _demandsCollection.doc(demandId).update({
      'isActive': false,
    });
  }

  Future<Demand?> getCurrentDemand() async {
    if (_auth.currentUser == null) {
      throw Exception('User is not logged in');
    }

    final query = await _demandsCollection
        .where(
          'userId',
          isEqualTo: _auth.currentUser!.uid,
        )
        .get();

    if (query.docs.isEmpty) {
      return null;
    }

    return Demand.fromFirebaseJson({
      'id': query.docs.first.id,
      ...query.docs.first.data(),
    });
  }

  Future<Demand?> getDemand({required String demandId}) async {
    final doc = await _demandsCollection.doc(demandId).get();

    final demand = Demand.fromFirebaseJson({
      'id': doc.id,
      ...doc.data()!,
    });

    // temp solution
    if (!demand.isActive) {
      return null;
    }
    return demand;
  }

  Future<List<Demand>> getDemands({
    required GoogleGeocodingLocation geo,
    required double? radius,
    required List<String>? categoryIds,
    required int page,
  }) async {
    try {
      return await _demandsApiClient.getDemands(
        geo: geo,
        page: page,
        radius: radius,
        categoryIds: categoryIds,
      );
    } catch (_) {
      rethrow;
    }
  }
}

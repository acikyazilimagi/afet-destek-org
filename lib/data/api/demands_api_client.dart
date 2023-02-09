// TODO(enes): use retrofit
import 'dart:convert';

import 'package:afet_destek/data/models/demand.dart';
import 'package:afet_destek/utils/logger/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class DemandsApiClient {
  Future<List<Demand>> getDemands({
    required GoogleGeocodingLocation geo,
    required double? radius,
    required List<String>? categoryIds,
    required int page,
  }) async {
    try {
      final payload = jsonEncode({
        'geo': {
          'longitude': geo.lng,
          'latitude': geo.lat,
        },
        'radius': radius,
        'categoryIds': categoryIds,
        'page': page
      });

      final response = await Dio().post<String>(
        'https://us-central1-deprem-destek-org.cloudfunctions.net/getDemands',
        data: payload,
      );

      AppLoggerImpl.log.i(response);
      // TODO(enes): use DTO for API parsing
      return ((jsonDecode(response.data!) as Map<String, dynamic>)['demands']
              as List<dynamic>)
          .map((e) => Demand.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      rethrow;
    }
  }
}

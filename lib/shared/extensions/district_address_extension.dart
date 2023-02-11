import 'package:google_geocoding_api/google_geocoding_api.dart';

extension DistrictAddresX on GoogleGeocodingResult {
  String get districtAddress {
    final addressComponentTypesInOrder = [
      'administrative_area_level_4',
      'administrative_area_level_3',
      'administrative_area_level_2',
      'administrative_area_level_1',
    ];
    final result = <String>[];
    for (final addressComponentType in addressComponentTypesInOrder) {
      for (final addressComponent in addressComponents) {
        if (addressComponent.types.contains(addressComponentType)) {
          result.add(addressComponent.longName);
        }
      }
    }

    return result.isNotEmpty
        ? result.join(', ')
        : addressComponents.first.longName;
  }
}

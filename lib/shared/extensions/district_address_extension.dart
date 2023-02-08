import 'package:google_geocoding_api/google_geocoding_api.dart';

extension DistrictAddresX on GoogleGeocodingResult {
  String get districtAddress {
    final addressComponentTypesInOrder = [
      'administrative_area_level_4',
      'administrative_area_level_3',
      'administrative_area_level_2',
      'administrative_area_level_1',
      'country',
    ];

    for (final addressComponentType in addressComponentTypesInOrder) {
      for (final addressComponent in addressComponents) {
        if (addressComponent.types.contains(addressComponentType)) {
          return addressComponent.longName;
        }
      }
    }

    return addressComponents.first.longName;
  }
}

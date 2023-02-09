import 'package:afet_destek/shared/extensions/district_address_extension.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GeoValueAccessor
    extends ControlValueAccessor<GoogleGeocodingResult, String> {
  @override
  String modelToViewValue(GoogleGeocodingResult? modelValue) {
    return modelValue == null ? '' : modelValue.districtAddress;
  }

  @override
  GoogleGeocodingResult? viewToModelValue(String? viewValue) {
    return null;
  }
}

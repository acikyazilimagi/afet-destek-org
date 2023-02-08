import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding_api/google_geocoding_api.dart';

class LocationRepository {
  final _googleGeocodingApi = GoogleGeocodingApi(
    // TODO(BRTZL): Get this from env
    'AIzaSyBhcGwfVK2wWFRwo7fpKQ64BLdH0qS6Nb0',
  );

  Future<GoogleGeocodingResult> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }

    final position = await Geolocator.getCurrentPosition();

    final res = await _googleGeocodingApi.reverse(
      '${position.latitude},${position.longitude}',
      language: 'tr',
    );

    return res.results.first;
  }
}

import 'package:location/location.dart';

class Locations {
  Locations(this.longitude, this.latitude);
  Locations.defaultConstructor()
      : longitude = 0.0,
        latitude = 0.0;

  double longitude;
  double latitude;

  Future<void> getCurrentLocation() async {
    try {
      Location location = Location();

      bool serviceEnabled;
      PermissionStatus permissionGranted;
      LocationData locationData;

      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      locationData = await location.getLocation();
      longitude = locationData.longitude!;
      latitude = locationData.latitude!;
    } catch (e) {
      print('Error getting location: $e');
    }
  }
}

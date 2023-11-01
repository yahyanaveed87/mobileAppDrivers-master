// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class PositionController {
  // ignore: empty_constructor_bodies
  PositionController() {}

  void observePosition(String shuttle) async {
    // ignore: avoid_print
    print('POSITION_DEBUG: observing position');
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: avoid_print
      print('POSITION_DEBUG: Location services are disabled.');
    } else {
      // ignore: avoid_print
      print('POSITION_DEBUG: Location services are enabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: avoid_print
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      // ignore: avoid_print
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.low,
      ),
    ).listen(
      (Position position) {
        // ignore: avoid_print
        print('POSITION_DEBUG: Position Updated: ${position.toString()}');
        FirebaseFirestore.instance.collection('shuttles').doc(shuttle).update(
            {'latitude': position.latitude, 'longitude': position.longitude});
      },
      onError: (Object e) {
        // ignore: avoid_print
        print('POSITION_DEBUG: Error: $e');
      },
      onDone: () {
        // ignore: avoid_print
        print('POSITION_DEBUG: Done');
      },
    );
  }

  void disposeObservers() {
    //_positionStream?.cancel();
  }
}

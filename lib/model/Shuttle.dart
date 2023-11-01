// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Shuttle {
  String registration = 'ABCDEF';
  String driver = 'None';
  String status = 'At Base';
  double latitude = -33.92805559378746;
  double longitude = 151.18593532338753;
  int statusTimestamp = 0;

  Shuttle(
      {required this.registration,
      required this.driver,
      required this.status,
      required this.latitude,
      required this.longitude,
      required this.statusTimestamp});

  Map<String, dynamic> toMap() {
    return {
      'registration': registration,
      'driver': driver,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'statusTimestamp': statusTimestamp
    };
  }

  factory Shuttle.fromMap(Map<String, dynamic> shuttleMap) {
    return Shuttle(
        registration: shuttleMap['registration'],
        driver: shuttleMap['driver'],
        status: shuttleMap['status'],
        latitude: shuttleMap['latitude'],
        longitude: shuttleMap['longitude'],
        statusTimestamp: shuttleMap['statusTimestamp']);
  }

  factory Shuttle.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Shuttle(
        registration: snapshot.data()!['registration'],
        driver: snapshot.data()!['driver'],
        status: snapshot.data()!['status'],
        latitude: snapshot.data()!['latitude'],
        longitude: snapshot.data()!['longitude'],
        statusTimestamp: snapshot.data()!.containsKey('statusTimestamp')
            ? snapshot.data()!['statusTimestamp'] as int
            : DateTime.now().millisecondsSinceEpoch);
  }
}

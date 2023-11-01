// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Arrival {
  final int arrivalTimestamp;
  final String bookingReference;
  final String customerFirstname;
  final double? latitude;
  final double? longitude;
  final int passengerCount;
  final bool? pickedUp;
  final int? arrivalTerminal;
  final int? pickUpTimestamp;
  final String id;
  final bool? droppedOff;
  final int? dropOffTimestamp;
  final int? rating;
  final String? comments;
  final String? driver;
  // final bool? requested;

  Arrival({
    required this.arrivalTimestamp,
    required this.bookingReference,
    required this.customerFirstname,
    required this.latitude,
    required this.longitude,
    required this.passengerCount,
    required this.pickedUp,
    required this.pickUpTimestamp,
    required this.id,
    required this.droppedOff,
    required this.dropOffTimestamp,
    required this.rating,
    required this.comments,
    required this.driver,
    // required this.requested,
    required this.arrivalTerminal,
  });

  Map<String, dynamic> toMap() {
    return {
      'arrivalTimestamp': arrivalTimestamp,
      'bookingReference': bookingReference,
      'customerFirstname': customerFirstname,
      'latitude': latitude,
      'longitude': longitude,
      'passengerCount': passengerCount,
      'pickedUp': pickedUp,
      'pickUpTimestamp': pickUpTimestamp,
      'id': id,
      'droppedOff': droppedOff,
      'dropOffTimestamp': dropOffTimestamp,
      'rating': rating,
      'comments': comments,
      'driver': driver,
      // 'requested': requested,
      'arrivalTerminal': arrivalTerminal,
    };
  }

  factory Arrival.fromMap(Map<String, dynamic> map) {
    return Arrival(
      arrivalTimestamp: map['arrivalTimestamp'],
      bookingReference: map['bookingReference'],
      customerFirstname: map['customerFirstname'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      passengerCount: map['passengerCount'] ?? 1,
      pickedUp: map['pickedUp'],
      pickUpTimestamp: map['pickUpTimestmap'],
      id: map['id'],
      droppedOff: map['droppedOff'],
      dropOffTimestamp: map['dropOffTimestamp'],
      rating: map['rating'],
      comments: map['comments'],
      driver: map['driver'],
      // requested: map['requested'],
      arrivalTerminal: map['arrivalTerminal'],
    );
  }

  factory Arrival.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Arrival(
      arrivalTimestamp: snapshot['arrivalTimestamp'] ?? "",
      bookingReference: snapshot['bookingReference'],
      customerFirstname: snapshot['customerFirstname'],
      latitude: snapshot['latitude'],
      longitude: snapshot['longitude'],
      passengerCount: snapshot['passengerCount'] ?? 1,
      pickedUp: snapshot['pickedUp'],
      id: snapshot['id'],
      pickUpTimestamp: snapshot['pickUpTimestamp'] ?? 0,
      droppedOff: snapshot['droppedOff'] ?? false,
      dropOffTimestamp: snapshot['dropOffTimestamp'] ?? 0,
      rating: snapshot['rating'],
      comments: snapshot['comments'] ?? '',
      // requested: snapshot['requested'] ?? '',
      driver: snapshot['driver'] ?? '',
      arrivalTerminal: snapshot.data().containsKey('arrivalTerminal')
          ? snapshot.data()['arrivalTerminal']
          : 2,
    );
  }
}

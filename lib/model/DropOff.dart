// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class DropOff {
  final String bookingReference;
  final String customerFirstname;
  final int checkInTimestamp;
  final int dropOffTimestamp;
  final int pickUpTimestamp;
  final bool droppedOff;
  final String comments;
  final String driver;
  final int rating;
  final int passengerCount;
  final String id;
  final String uid;
  final bool pickedUp;
  // final bool checkedIn;
  final String departureTerminal;

  DropOff({
    required this.bookingReference,
    required this.customerFirstname,
    required this.checkInTimestamp,
    required this.dropOffTimestamp,
    required this.droppedOff,
    required this.comments,
    required this.driver,
    required this.rating,
    required this.passengerCount,
    required this.id,
    required this.uid,
    required this.pickUpTimestamp,
    required this.pickedUp,
    // required this.checkedIn,
    required this.departureTerminal,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingReference': bookingReference,
      'customerFirstname': customerFirstname,
      'checkInTimestamp': checkInTimestamp,
      'dropOffTimestamp': dropOffTimestamp,
      'droppedOff': droppedOff,
      'comments': comments,
      'driver': driver,
      'rating': rating,
      'passengerCount': passengerCount,
      'id': id,
      'uid': uid,
      'pickUpTimestamp': pickUpTimestamp,
      'pickedUp': pickedUp,
      // 'checkedIn': checkedIn,
      'departureTerminal': departureTerminal,
    };
  }

  factory DropOff.fromMap(Map<String, dynamic> map) {
    return DropOff(
      bookingReference: map['bookingReference'],
      customerFirstname: map['customerFirstname'],
      checkInTimestamp: map['checkInTimestamp'],
      dropOffTimestamp: map['dropOffTimestamp'],
      droppedOff: map['droppedOff'],
      comments: map['comments'],
      driver: map['driver'],
      rating: map['rating'],
      passengerCount: map['passengerCount'],
      id: map['id'],
      uid: map['uid'],
      pickUpTimestamp: map['pickUpTimestamp'],
      pickedUp: map['pickedUp'],
      // checkedIn: map['checkedIn'],
      departureTerminal: map['departureTerminal'],
    );
  }

  factory DropOff.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return DropOff(
      bookingReference: snapshot['bookingReference'],
      customerFirstname: snapshot['customerFirstname'],
      checkInTimestamp: snapshot['checkInTimestamp'],
      dropOffTimestamp: snapshot['dropOffTimestamp'],
      droppedOff: snapshot['droppedOff'],
      comments: snapshot['comments'],
      driver: snapshot['driver'],
      rating: snapshot['rating'],
      passengerCount: snapshot['passengerCount'],
      id: snapshot['id'],
      uid: snapshot['uid'],
      pickUpTimestamp: snapshot['pickUpTimestamp'],
      pickedUp: snapshot['pickedUp'],
      // checkedIn: snapshot['checkedIn'],
      departureTerminal: snapshot.data().containsKey('departureTerminal')
          ? snapshot.data()['departureTerminal']
          : 'domestic',
    );
  }
}

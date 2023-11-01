// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:space_shuttle_driver/model/DropOff.dart';
import 'package:space_shuttle_driver/utils/constants.dart';

class DeparturesController {
  late StreamSubscription dropOffStream;
  final internalDepartures = <DropOff>[].obs;
  final domesticDepartures = <DropOff>[].obs;
  final pickedUpDepartures = <DropOff>[].obs;
  DeparturesController() {
    observeDepartures();
  }

  void observeDepartures() {
    dropOffStream = FirebaseFirestore.instance
        .collection('dropOffs')
        .where('pickedUp', isEqualTo: false)
        .where('droppedOff', isEqualTo: false)
/*  .where('departureTimestamp', isGreaterThan: getTodayStartInMillisecondsSinceEpoch())
    .where('departureTimestamp', isLessThan: getTodayEndInMillisecondsSinceEpoch())*/
        // .where('checkedIn', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      domesticDepartures.value = List.from(snapshot.docs
          .map((doc) => DropOff.fromSnapshot(doc))
          .where((departure) => departure.departureTerminal == 'Domestic'));
      internalDepartures.value = List.from(snapshot.docs
          .map((doc) => DropOff.fromSnapshot(doc))
          .where(
              (departure) => departure.departureTerminal == 'International'));
      domesticDepartures
          .sort((a, b) => a.checkInTimestamp.compareTo(b.checkInTimestamp));
      internalDepartures
          .sort((a, b) => a.checkInTimestamp.compareTo(b.checkInTimestamp));
    });
  }

  void addPickup(DropOff dropOff) async {
    if (pickedUpDepartures.isEmpty) {
      //if (pickedUpDepartures.none((element) => element.id == dropOff.id)) {
      pickedUpDepartures.add(dropOff);
      FirebaseFirestore.instance.collection('dropOffs').doc(dropOff.id).update({
        'pickedUp': true,
        'pickUpTimestamp': DateTime.now().millisecondsSinceEpoch
      });
    } else {
      showGetSnackbar('Heads up!', 'Please drop already picked up customer.');
    }
  }

  void removePickup(DropOff dropOff) {
    if (pickedUpDepartures.any((element) => element.id == dropOff.id)) {
      pickedUpDepartures.removeWhere((element) => element.id == dropOff.id);
      FirebaseFirestore.instance
          .collection('dropOffs')
          .doc(dropOff.id)
          .update({'pickedUp': false});
    }
  }

  void disposeObservers() {
    dropOffStream.cancel();
  }

  void dropEveryoneOff() {
    // ignore: avoid_function_literals_in_foreach_calls
    pickedUpDepartures.forEach((departure) {
      FirebaseFirestore.instance
          .collection('dropOffs')
          .doc(departure.id)
          .update({
        'droppedOff': true,
        'dropOffTimestamp': DateTime.now().millisecondsSinceEpoch
      });
    });
    pickedUpDepartures.clear();
  }

  getTodayStartInMillisecondsSinceEpoch() {
    DateTime today = DateTime.now();
    DateTime todayStart = DateTime(today.year, today.month, today.day);
    return todayStart.millisecondsSinceEpoch;
  }

  getTodayEndInMillisecondsSinceEpoch() {
    DateTime today = DateTime.now();
    DateTime todayEnd =
        DateTime(today.year, today.month, today.day, 23, 59, 59);
    return todayEnd.millisecondsSinceEpoch;
  }
}

// ignore: file_names
// ignore_for_file: avoid_function_literals_in_foreach_calls, file_names, duplicate_ignore

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../model/Arrival.dart';
import 'package:space_shuttle_driver/utils/constants.dart';

class ArrivalsController {
  late StreamSubscription pickupStream;
  final internationalArrivals = <Arrival>[].obs;
  final domesticArrivals = <Arrival>[].obs;
  final pickedUpArrivals = <Arrival>[].obs;

  ArrivalsController() {
    observeArrivals();
  }

  void observeArrivals() {
    pickupStream = FirebaseFirestore.instance
        .collection('arrivals')
        .where('pickedUp', isEqualTo: false)
        .where('droppedOff', isEqualTo: false)
        /*.where('arrivalTimestamp', isGreaterThan: getTodayStartInMillisecondsSinceEpoch())
        .where('arrivalTimestamp', isLessThan: getTodayEndInMillisecondsSinceEpoch())*/
        // .where('requested', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      domesticArrivals.value = List.from(snapshot.docs
          .map((doc) => Arrival.fromSnapshot(doc))
          .where((arrival) =>
              (arrival.arrivalTerminal == 2 || arrival.arrivalTerminal == 3)));
      internationalArrivals.value = List.from(snapshot.docs
          .map((doc) => Arrival.fromSnapshot(doc))
          .where((arrival) => arrival.arrivalTerminal == 1));
      domesticArrivals
          .sort((a, b) => a.arrivalTimestamp.compareTo(b.arrivalTimestamp));
      internationalArrivals
          .sort((a, b) => a.arrivalTimestamp.compareTo(b.arrivalTimestamp));
    });
  }

  void addPickup(Arrival arrival) {
    // ignore: avoid_print
    print('adding pickup');
    if (pickedUpArrivals.isEmpty) {
      // arrival['pickUpTimestamp'] = DateTime.now().millisecondsSinceEpoch;
      // if (pickedUpArrivals.none((element) => element.id == arrival.id)) {
      pickedUpArrivals.add(arrival);
      FirebaseFirestore.instance.collection('arrivals').doc(arrival.id).update({
        'pickedUp': true,
        'pickUpTimestamp': DateTime.now().millisecondsSinceEpoch
      });
    } else {
      showGetSnackbar('Heads up!', 'Please drop already picked up customer.');
    }
  }

  void removePickup(Arrival arrival) {
    if (pickedUpArrivals.any((element) => element.id == arrival.id)) {
      pickedUpArrivals.removeWhere((element) => element.id == arrival.id);
      FirebaseFirestore.instance
          .collection('arrivals')
          .doc(arrival.id)
          .update({'pickedUp': false});
    }
  }

  void dropEveryoneOff() {
    pickedUpArrivals.forEach((arrival) {
      FirebaseFirestore.instance.collection('arrivals').doc(arrival.id).update({
        'droppedOff': true,
        'dropOffTimestamp': DateTime.now().millisecondsSinceEpoch
      });
    });
    pickedUpArrivals.clear();
  }

  void disposeObservers() {
    pickupStream.cancel();
  }

  getTodayStartInMillisecondsSinceEpoch() {
    DateTime today = DateTime.now();
    return DateTime(today.year, today.month, today.day).millisecondsSinceEpoch;
  }

  getTodayEndInMillisecondsSinceEpoch() {
    DateTime today = DateTime.now();
    return DateTime(today.year, today.month, today.day, 23, 59, 59)
        .millisecondsSinceEpoch;
  }
}

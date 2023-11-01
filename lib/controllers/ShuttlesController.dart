// ignore_for_file: file_names

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Shuttle.dart';

class ShuttlesController {
  late StreamSubscription shuttlesStream;
  RxString activeShuttle = ''.obs;

  RxList<Shuttle> shuttles = <Shuttle>[].obs;

  ShuttlesController() {
    observeShuttles();
    checkActiveShuttle();
  }

  void createShuttle(Shuttle shuttle) {
    FirebaseFirestore.instance
        .collection('shuttles')
        .doc(shuttle.registration)
        .set(shuttle.toMap());
  }

  void observeShuttles() {
    shuttlesStream = FirebaseFirestore.instance
        .collection('shuttles')
        .snapshots()
        .listen((snapshot) {
      shuttles.value =
          List.from(snapshot.docs.map((doc) => Shuttle.fromSnapshot(doc)));
    });
  }

  void deleteShuttle(Shuttle shuttle) {
    FirebaseFirestore.instance
        .collection('shuttles')
        .doc(shuttle.registration)
        .delete();
  }

  void setActiveShuttle(String rego) {
    activeShuttle.value = rego;
  }

  Shuttle? getActiveShuttle() {
    // ignore: invalid_use_of_protected_member
    return shuttles.value
        .firstWhere((element) => element.registration == activeShuttle.value);
  }

  void disposeObservers() {
    shuttlesStream.cancel();
  }

  void checkActiveShuttle() {
    SharedPreferences.getInstance().then((prefs) {
      activeShuttle.value = prefs.getString('shuttle') ?? '';
    });
  }
}

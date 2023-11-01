// ignore: file_names
// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Staff.dart';

class StaffController {
  late StreamSubscription staffStream;

  RxList<Staff> staff = <Staff>[].obs;
  RxString activeStaff = ''.obs;
  RxString activeShuttle = ''.obs;
  RxString currentStatus = ''.obs;

  StaffController() {
    observeStaff();
    checkActiveStaff();
  }

  void observeStaff() {
    staffStream = FirebaseFirestore.instance
        .collection('staff')
        .snapshots()
        .listen((snapshot) {
      staff.value =
          List.from(snapshot.docs.map((doc) => Staff.fromSnapshot(doc)));
    });
  }

  void disposeObservers() {
    staffStream.cancel();
  }

  void updateCurrentStatus(String status) {
    currentStatus.value = status;
    FirebaseFirestore.instance
        .collection('shuttles')
        .doc(activeShuttle.value)
        .update({'status': status});
  }

  Future staffAlreadyExists(String name) async {
    var staff = await FirebaseFirestore.instance
        .collection('staff')
        .where('name', isEqualTo: name)
        .get();
    return staff.docs.isNotEmpty;
  }

  Future createStaff(Staff staff) async {
    bool exists = await staffAlreadyExists(staff.name);
    if (!exists) {
      await FirebaseFirestore.instance
          .collection('staff')
          .doc(staff.id)
          .set(staff.toMap());
      return true;
    } else {
      return false;
    }
  }

  void setActiveDriver(String uid, String registration) async {
    activeStaff.value = uid;
    activeShuttle.value = registration;
    // ignore: avoid_print
    print('setting active staff');
    // ignore: avoid_print
    print(activeStaff.value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('driver', uid);
    prefs.setString('shuttle', registration);
    prefs.setInt('timestamp', DateTime.now().millisecondsSinceEpoch);
    FirebaseFirestore.instance
        .collection('shuttles')
        .doc(activeShuttle.value)
        .update({
      'driver': getActiveStaff()?.name,
      'statusTimestamp': DateTime.now().millisecondsSinceEpoch
    });
  }

  Future<int> getActiveDriverTimestamp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('timestamp') ?? 0;
  }

  // ignore: body_might_complete_normally_nullable
  Staff? getActiveStaff() {
    if (activeStaff.value != '') {
      var result =
          // ignore: invalid_use_of_protected_member
          staff.value.firstWhere((element) => element.id == activeStaff.value);
      // ignore: avoid_print
      print("staff found: ${result.name}");
      return result;
    }
  }

  Future deleteStaff(Staff staff) async {
    return await FirebaseFirestore.instance
        .collection('staff')
        .doc(staff.id)
        .delete();
  }

  Future updateStaff(Staff staff) async {
    return await FirebaseFirestore.instance
        .collection('staff')
        .doc(staff.id)
        .update(staff.toMap());
  }

  void checkActiveStaff() {
    SharedPreferences.getInstance().then((prefs) {
      activeStaff.value = prefs.getString('driver') ?? '';
      activeShuttle.value = prefs.getString('shuttle') ?? '';
    });
  }

  void updateStatus(String s) async {
    await FirebaseFirestore.instance
        .collection('shuttles')
        .doc(activeShuttle.value)
        .update({
      'status': s,
      'statusTimestamp': DateTime.now().millisecondsSinceEpoch
    });
    currentStatus.value = s;
  }

  void signOff() async {
    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('driver');
      prefs.remove('shuttle');
      prefs.remove('timestamp');
      activeStaff.value = '';
      activeShuttle.value = '';
    });
    // Get.to(() => LoginPage());
    FirebaseFirestore.instance
        .collection('shuttles')
        .doc(activeShuttle.value)
        .update({
      'driver': 'None',
      'status': 'At Base',
      'statusTimestamp': DateTime.now().millisecondsSinceEpoch
    });
  }
}

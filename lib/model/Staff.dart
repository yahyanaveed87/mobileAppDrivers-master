// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Staff {
  String name;
  String pin;
  final String id;

  Staff({
    required this.name,
    required this.pin,
    required this.id,
  });

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'],
      pin: map['pin'],
      id: map['id'],
    );
  }

  factory Staff.fromSnapshot(DocumentSnapshot snapshot) {
    return Staff(
      name: snapshot['name'],
      pin: snapshot['pin'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'pin': pin,
      'id': id,
    };
  }
}

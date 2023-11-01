import 'package:flutter/material.dart';

import 'package:space_shuttle_driver/model/DropOff.dart';

// ignore: must_be_immutable
class PickupTileDeparture extends StatelessWidget {
  DropOff dropOff;
  // ignore: use_super_parameters
  PickupTileDeparture({Key? key, required this.dropOff}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      width: 100,
      height: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            getTruncatedName(dropOff.customerFirstname),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(dropOff.pickUpTimestamp)).inMinutes.toString()} mins ago',
            style: const TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.person,
                color: Colors.black,
                size: 12,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                '${dropOff.passengerCount}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }

  String getTruncatedName(String customerFirstname) {
    if (customerFirstname.length > 10) {
      return '${customerFirstname.substring(0, 10)}...';
    } else {
      return customerFirstname;
    }
  }
}

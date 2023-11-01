import 'package:flutter/material.dart';
import 'package:space_shuttle_driver/model/Arrival.dart';

// ignore: must_be_immutable
class PickupTileArrival extends StatelessWidget {
  Arrival arrival;
  // ignore: use_super_parameters
  PickupTileArrival({Key? key, required this.arrival}) : super(key: key);

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
            getTruncatedName(arrival.customerFirstname),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(arrival.pickUpTimestamp ?? 0)).inMinutes.toString()} mins ago',
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
                '${arrival.passengerCount}',
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

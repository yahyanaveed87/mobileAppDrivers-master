// ignore_for_file: unnecessary_string_interpolations, unnecessary_brace_in_string_interps, duplicate_ignore, use_super_parameters

import 'package:flutter/material.dart';
import 'package:space_shuttle_driver/utils/colors.dart';

import '../model/Arrival.dart';

// ignore: must_be_immutable
class ArrivalTile extends StatelessWidget {
  Arrival arrival;
  Function() onTap;
  ArrivalTile({Key? key, required this.arrival, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arrivalTime = DateTime.now()
        .difference(
            DateTime.fromMillisecondsSinceEpoch(arrival.arrivalTimestamp))
        .inMinutes;
    var arrivalText = '';
    // ignore: duplicate_ignore
    if (arrivalTime > 0) {
      // ignore: unnecessary_brace_in_string_interps
      arrivalText = 'Arrived ${arrivalTime} mins ago';
    } else {
      arrivalText = 'Arriving in ${(arrivalTime * -1)} mins';
    }
    return InkWell(
      splashColor: Colors.red,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onTap();
      },
      child: Ink(
        child: Container(
          width: 250,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: whiteShade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                arrival.customerFirstname,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '${arrivalText}',
                style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 10),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
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
        ),
      ),
    );
  }
}

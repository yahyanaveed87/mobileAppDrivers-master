import 'package:flutter/material.dart';
import 'package:space_shuttle_driver/model/DropOff.dart';
import 'package:space_shuttle_driver/utils/colors.dart';

// ignore: must_be_immutable
class DepartureTile extends StatelessWidget {
  DropOff dropOff;
  Function() onTap;
  // ignore: use_super_parameters
  DepartureTile({Key? key, required this.dropOff, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.red,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        onTap();
      },
      child: Ink(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: whiteShade,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dropOff.customerFirstname,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Waiting since ${DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(dropOff.checkInTimestamp)).inMinutes.toString()} mins ago',
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
        ),
      ),
    );
  }
}

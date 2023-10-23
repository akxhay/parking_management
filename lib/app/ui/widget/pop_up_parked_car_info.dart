import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/constants/generic_constants.dart';
import '../../data/dto/response_dto.dart';

class ParkedCarInfoDialog extends StatelessWidget {
  final ParkingSlotDto parkingSlotDto;
  final Function() callback;

  const ParkedCarInfoDialog(
      {super.key, required this.parkingSlotDto, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(parkingSlotDto.arrivedAt ?? 0);
    Duration timeDifference = DateTime.now().difference(dateTime);
    int billingHours = timeDifference.inHours + 1;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Parking departure receipt',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          ParkingCarInfo(
            label: 'Number plate',
            value: parkingSlotDto.numberPlate ?? "",
          ),
          ParkingCarInfo(
              label: 'Arrived date',
              value: DateFormat(GenericConstants.parkingDateFormat)
                  .format(dateTime)),
          ParkingCarInfo(
              label: 'Arrived time',
              value: DateFormat(GenericConstants.parkingTimeFormat)
                  .format(dateTime)),
          ParkingCarInfo(
              label: 'Billing hours', value: billingHours.toString()),
          ParkingCarInfo(
              label: 'Billing rate',
              value: "${GenericConstants.parkingPricePerHour} ₹/hour"),
          ParkingCarInfo(
              label: 'Bill',
              value:
                  "${GenericConstants.parkingPricePerHour * billingHours} ₹"),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16, // Increase font size
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  callback();
                },
                child: const Text(
                  'Release',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ParkingCarInfo extends StatelessWidget {
  final String label;
  final String value;

  const ParkingCarInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '$label:',
          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}

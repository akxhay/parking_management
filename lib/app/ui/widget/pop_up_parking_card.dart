import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/constants/generic_constants.dart';
import '../../data/dto/response_dto.dart';
class ParkingReceiptDialog extends StatelessWidget {
  final ReservedParkingSlotDto availableParkingSlotDto;

  const ParkingReceiptDialog(
      {super.key, required this.availableParkingSlotDto});

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
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
        availableParkingSlotDto.arrivedAt ?? 0);

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
            'Parking arrival receipt',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          ParkingReceiptInfo(
            label: 'Floor name',
            value: availableParkingSlotDto.floorName,
          ),
          ParkingReceiptInfo(
            label: 'Slot type',
            value: GenericConstants.carTypes[availableParkingSlotDto.slotType]!,
          ),
          ParkingReceiptInfo(
            label: 'Slot number',
            value: availableParkingSlotDto.slotNumber.toString(),
          ),
          ParkingReceiptInfo(
            label: 'Number plate',
            value: availableParkingSlotDto.numberPlate ?? "",
          ),
          ParkingReceiptInfo(
              label: 'Arrived date',
              value: DateFormat(GenericConstants.parkingDateFormat)
                  .format(dateTime)),
          ParkingReceiptInfo(
              label: 'Arrived time',
              value: DateFormat(GenericConstants.parkingTimeFormat)
                  .format(dateTime)),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ParkingReceiptInfo extends StatelessWidget {
  final String label;
  final String value;

  const ParkingReceiptInfo(
      {super.key, required this.label, required this.value});

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
import 'package:flutter/material.dart';
import 'package:parking/app/data/dto/request_dto.dart';
import 'package:parking/app/util/common_method.dart';
import 'package:parking/app/util/edit_text_box_number.dart';

class CreateNewItemView extends StatefulWidget {
  const CreateNewItemView({super.key, required this.callback});

  final Function(DummyDto?) callback;

  @override
  State<CreateNewItemView> createState() => _CreateNewItemViewState();
}

class _CreateNewItemViewState extends State<CreateNewItemView> {
  int parkingLots = 1;
  int floorsPerParkingLot = 1;
  int smallSlotsPerFloor = 1;
  int mediumSlotsPerFloor = 1;
  int largeSlotsPerFloor = 1;
  int xLargeSlotsPerFloor = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(children: [
          CustomEditTextBoxNumber(
              number: parkingLots,
              label: "Parking Lots",
              callback: (p0) => parkingLots = p0),
          CustomEditTextBoxNumber(
              number: floorsPerParkingLot,
              label: "Floors Per Parking Lot",
              callback: (p0) => floorsPerParkingLot = p0),
          CustomEditTextBoxNumber(
              number: smallSlotsPerFloor,
              label: "Small Slots Per Floor",
              callback: (p0) => smallSlotsPerFloor = p0),
          CustomEditTextBoxNumber(
              number: mediumSlotsPerFloor,
              label: "Medium Slots Per Floor",
              callback: (p0) => mediumSlotsPerFloor = p0),
          CustomEditTextBoxNumber(
              number: largeSlotsPerFloor,
              label: "Large Slots Per Floor",
              callback: (p0) => largeSlotsPerFloor = p0),
          CustomEditTextBoxNumber(
              number: xLargeSlotsPerFloor,
              label: "X Large Slots Per Floor",
              callback: (p0) => xLargeSlotsPerFloor = p0),
          ElevatedButton(
            onPressed: () {
              if (parkingLots < 1) {
                CommonMethods.showToast(
                    context: context,
                    text: "Parking Lots should be greateer than zero");
                return;
              }
              if (floorsPerParkingLot < 1) {
                CommonMethods.showToast(
                    context: context,
                    text: "floors should be greateer than zero");
                return;
              }
              if (smallSlotsPerFloor < 1) {
                CommonMethods.showToast(
                    context: context,
                    text: "Slots should be greateer than zero");
                return;
              }
              if (mediumSlotsPerFloor < 1) {
                CommonMethods.showToast(
                    context: context,
                    text: "Slots should be greateer than zero");
                return;
              }
              if (largeSlotsPerFloor < 1) {
                CommonMethods.showToast(
                    context: context,
                    text: "Slots should be greateer than zero");
                return;
              }
              if (xLargeSlotsPerFloor < 1) {
                CommonMethods.showToast(
                    context: context,
                    text: "Slots should be greateer than zero");
                return;
              }
              widget.callback(DummyDto(
                  parkingLots: parkingLots,
                  floorsPerParkingLot: floorsPerParkingLot,
                  smallSlotsPerFloor: smallSlotsPerFloor,
                  mediumSlotsPerFloor: mediumSlotsPerFloor,
                  largeSlotsPerFloor: largeSlotsPerFloor,
                  xLargeSlotsPerFloor: xLargeSlotsPerFloor));
              Navigator.pop(context);
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          )
        ]),
      ),
    );
  }
}

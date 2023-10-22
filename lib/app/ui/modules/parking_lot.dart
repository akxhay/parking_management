import 'package:flutter/material.dart';
import 'package:parking/app/data/dto/response_dto.dart';

class ParkingLotPage extends StatefulWidget {
  const ParkingLotPage({super.key, required this.parkingLot});

  final ParkingLotResponseDto parkingLot;

  @override
  State<ParkingLotPage> createState() => _ParkingLotPageState();
}

class _ParkingLotPageState extends State<ParkingLotPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return floorDetails(context);
  }

  Widget floorDetails(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text(widget.parkingLot.name)),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0.0, 0.0),
          child: ListView.builder(
              itemCount: widget.parkingLot.floors.length,
              itemBuilder: (context, index) {
                return makeListTile(context, widget.parkingLot.floors[index]);
              }),
        ));
  }

  Widget makeListTile(BuildContext context, FloorResponseDto floor) {
    return ListTile(
      title: Text(floor.name),
      subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildRowList(floor.parkingSlots)),
    );
  }

  List<Widget> _buildRowList(List<ParkingSlotDto> parkingSlots) {
    List<Widget> slotWidget = [];
    int totalSmallSlots = 0;
    int availableSmallSlots = 0;
    int totalMediumSlots = 0;
    int availableMediumSlots = 0;
    int totalLargeSlots = 0;
    int availableLargeSlots = 0;
    int totalXLargeSlots = 0;
    int availablelXLargeSlots = 0;

    for (var i = 0; i < parkingSlots.length; i++) {
      if (parkingSlots[i].slotType == 's') {
        totalSmallSlots++;
        if (!parkingSlots[i].occupied) availableSmallSlots++;
      } else if (parkingSlots[i].slotType == 'm') {
        totalMediumSlots++;
        if (!parkingSlots[i].occupied) availableMediumSlots++;
      } else if (parkingSlots[i].slotType == 'l') {
        totalLargeSlots++;
        if (!parkingSlots[i].occupied) availableLargeSlots++;
      } else if (parkingSlots[i].slotType == 'xl') {
        totalXLargeSlots++;
        if (!parkingSlots[i].occupied) availablelXLargeSlots++;
      }
    }

    slotWidget.add(Text("s: $availableSmallSlots"));
    slotWidget.add(Text("m: $availableMediumSlots"));
    slotWidget.add(Text("l: $availableLargeSlots"));
    slotWidget.add(Text("xl: $availablelXLargeSlots"));

    return slotWidget;
  }
}

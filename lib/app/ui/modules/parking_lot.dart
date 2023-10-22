import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/app/data/dto/response_dto.dart';
import 'package:parking/app/ui/modules/park_car.dart';

import '../../data/service/bloc/parking/parking_bloc.dart';
import '../../util/common_method.dart';
import '../../widget/loaders.dart';

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
    return BlocConsumer<ParkingLotBloc, ParkingLotState>(
        listener: (context, state) {
      if (state is GetParkingLotLoadingState) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => loadingIndicator(context, "getting parking lot"));
      } else if (state is GetParkingLotSuccessState) {
        Navigator.of(context, rootNavigator: true).pop();
        parkingCard(context, (state.availableParkingSlotDto));
      } else if (state is GetParkingLotErrorState) {
        Navigator.of(context, rootNavigator: true).pop();
        CommonMethods.showToast(
            context: context, text: state.error, seconds: 2);
      }
    }, buildWhen: (prev, curr) {
      return curr is GetParkingLotSuccessState;
    }, builder: (context, state) {
      return floorDetails(context);
    });
  }

  Widget floorDetails(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: Text(widget.parkingLot.name)),
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: widget.parkingLot.floors.length,
                      itemBuilder: (context, index) {
                        return makeListTile(
                            context, widget.parkingLot.floors[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom:
                          200.0), // Adjust the distance from the bottom as needed
                  child: ElevatedButton(
                    onPressed: () {
                      parkingCard(
                          context,
                          AvailableParkingSlotDto(
                              slotId: 1,
                              slotType: " 1",
                              slotNumber: 1,
                              floorId: 1,
                              floorName: " 1"));
                      // parkCar(context, (String a) {
                      //   BlocProvider.of<ParkingLotBloc>(context).add(
                      //       GetParkingSlotEvent(
                      //           parkingId: widget.parkingLot.id, size: a!));
                      // });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Button border radius
                      ),
                    ),
                    child: const Text(
                      'Enter car',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            )));
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
    int availableXLargeSlots = 0;

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
        if (!parkingSlots[i].occupied) availableXLargeSlots++;
      }
    }

    slotWidget.add(Text("s: $availableSmallSlots/$totalSmallSlots"));
    slotWidget.add(Text("m: $availableMediumSlots/$totalMediumSlots"));
    slotWidget.add(Text("l: $availableLargeSlots/$totalLargeSlots"));
    slotWidget.add(Text("xl: $availableXLargeSlots/$totalXLargeSlots"));

    return slotWidget;
  }

  void parkCar(BuildContext context, Function(String a) callBack) {
    String selectedValue = "s";
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Create New Item',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: ParkCarView(
          callBack: (String? a) {
            selectedValue = a!;
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 14,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              callBack(selectedValue);
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void parkingCard(
      BuildContext context, AvailableParkingSlotDto availableParkingSlotDto) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(
          'Parking Receipt',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          height: 100,
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Floor name: ${availableParkingSlotDto.floorName}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Slot type: ${availableParkingSlotDto.slotType}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Slot number: ${availableParkingSlotDto.slotNumber}',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Ok',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

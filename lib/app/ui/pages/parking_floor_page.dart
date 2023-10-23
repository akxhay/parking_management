import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/app/data/constants/generic_constants.dart';
import 'package:parking/app/data/dto/response_dto.dart';
import 'package:parking/app/util/common_method.dart';

import '../../data/service/parking_bloc/parking_bloc.dart';
import '../widget/loaders.dart';

class ParkingFloorPage extends StatefulWidget {
  const ParkingFloorPage({super.key, required this.context});

  final BuildContext context;

  @override
  State<ParkingFloorPage> createState() => _ParkingFloorPageState();
}

class _ParkingFloorPageState extends State<ParkingFloorPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Map<String, List<ParkingSlotDto>> map = {};
  int? updatedId;

  late final int parkingId;

  late final FloorResponseDto parkingFloor;

  @override
  void initState() {
    super.initState();
    var argsMap = ModalRoute.of(widget.context)!.settings.arguments
        as Map<String, Object>;
    parkingId = argsMap["parkingId"] as int;
    parkingFloor = argsMap["parkingFloor"] as FloorResponseDto;

    map["s"] = [];
    map["m"] = [];
    map["l"] = [];
    map["xl"] = [];

    for (var slot in parkingFloor.parkingSlots) {
      final String slotType = slot.slotType;
      if (map.containsKey(slotType)) {
        map[slotType]?.add(slot);
      } else {
        map[slotType] = [slot];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingLotBloc, ParkingLotState>(
        listener: (context, state) {
      if (state is ReleaseParkingLotLoadingState) {
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => loadingIndicator(context, "releasing parking lot"));
      } else if (state is ReleaseParkingLotSuccessState) {
        updateParkingFloor(parkingFloor, updatedId);
        Navigator.of(context, rootNavigator: true).pop();
      } else if (state is ReleaseParkingLotErrorState) {
        Navigator.of(context, rootNavigator: true).pop();
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => messageDialog(context, "Failed", state.error));
      }
    }, buildWhen: (prev, curr) {
      return curr is ReleaseParkingLotSuccessState;
    }, builder: (context, state) {
      return floorDetails(context);
    });
  }

  Widget floorDetails(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(parkingFloor.name)),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0.0, 0.0),
        child: Column(
          children: <Widget>[
            for (var slotType in map.keys)
              ExpansionTile(
                initiallyExpanded: false, // Set to true if you want them initially expanded
                title: Text(
                  'Car size : ${GenericConstants.carTypes[slotType]}',
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (screenWidth / 50).floor(),
                      crossAxisSpacing: 2.0,
                      mainAxisSpacing: 2.0,
                    ),
                    itemCount: map[slotType]!.length,
                    itemBuilder: (context, index) {
                      String slotNumber = map[slotType]![index].slotNumber.toString();
                      bool occupied = map[slotType]![index].occupied;

                      return Card(
                        color: occupied ? Colors.red : Colors.white,
                        child: TextButton(
                          onPressed: () {
                            if (!occupied) {
                              CommonMethods.showToast(
                                context: context,
                                text: "This slot is already free",
                              );
                            } else {
                              releaseSlot(context, map[slotType]![index].id);
                            }
                          },
                          child: Text(
                            slotNumber,
                            style: TextStyle(
                              color: occupied ? Colors.white : Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }


  void releaseSlot(BuildContext context, int slotId) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'release Item',
                style: TextStyle(),
              ),
              content: const Text(
                'Press OK to release Item',
                style: TextStyle(),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'OK');
                    setState(() {
                      updatedId = slotId;
                    });
                    BlocProvider.of<ParkingLotBloc>(context).add(
                        ReleaseParkingSlotEvent(
                            slotId: slotId, parkingId: parkingId));
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ));
  }

  void updateParkingFloor(FloorResponseDto parkingFloor, int? updatedId) {
    setState(() {
      parkingFloor.parkingSlots
          .where((element) => element.id == updatedId)
          .first
          .occupied = false;
    });
  }
}

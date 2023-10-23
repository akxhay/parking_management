import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/app/data/constants/generic_constants.dart';
import 'package:parking/app/data/dto/response_dto.dart';
import 'package:parking/app/ui/widget/pop_up_park_car.dart';

import '../../data/dto/generic_dto.dart';
import '../../data/service/parking_bloc/parking_bloc.dart';
import '../../routes/app_routes.dart';
import '../widget/loaders.dart';
import '../widget/pop_up_parking_card.dart';

class ParkingLotPage extends StatefulWidget {
  const ParkingLotPage({super.key, required this.context});

  final BuildContext context;

  @override
  State<ParkingLotPage> createState() => _ParkingLotPageState();
}

class _ParkingLotPageState extends State<ParkingLotPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final ParkingLotResponseDto parkingLot;

  @override
  void initState() {
    super.initState();

    parkingLot = ModalRoute.of(widget.context)!.settings.arguments
        as ParkingLotResponseDto;

    // Now you can use the parkingLot object within your stateful widget.
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ParkingLotBloc, ParkingLotState>(
        listener: (context, state) {
      if (state is GetParkingLotLoadingState) {
        loadingIndicator(context, "getting parking lot");
      } else if (state is GetParkingLotSuccessState) {
        updateParkingLot(parkingLot, state.availableParkingSlotDto);
        Navigator.pop(context); // Close the loading indicator dialog.
        parkingCard(context, (state.availableParkingSlotDto));
      } else if (state is GetParkingLotErrorState) {
        Navigator.pop(context); // Close the loading indicator dialog.
        WidgetsBinding.instance.addPostFrameCallback(
            (_) => messageDialog(context, "Failed", state.error));
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
        appBar: AppBar(title: Text(parkingLot.name)),
        backgroundColor: Colors.white,
        floatingActionButton: parkingFloorFloats(context),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0.0, 0.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: parkingLot.floors.length,
                      itemBuilder: (context, index) {
                        return makeListTile(
                            context, parkingLot.floors[index], parkingLot.id);
                      }),
                ),
              ],
            )));
  }

  Widget makeListTile(
      BuildContext context, FloorResponseDto floor, int parkingId) {
    return ListTile(
      title: Text(floor.name),
      subtitle: _buildDataTable(floor.parkingSlots),
      onTap: () {
        Navigator.of(context).pushNamed(AppRoute.parkingFloor,
            arguments: <String, Object>{
              "parkingFloor": floor,
              "parkingId": parkingId
            }).then((value) {
          setState(() {
            parkingLot.floors = FloorResponseDto.fromJsonArray(
                parkingLot.floors.map((e) => e.toMap()).toList());
          });
        });
      },
    );
  }

  Widget _buildDataTable(List<ParkingSlotDto> parkingSlots) {
    final slotData = <String, SlotData>{};

    for (var slotType in GenericConstants.carTypes.keys) {
      slotData[slotType] = SlotData(slotType);
    }

    for (var slot in parkingSlots) {
      if (slotData.containsKey(slot.slotType)) {
        slotData[slot.slotType]!.totalSlots++;
        if (!slot.occupied) {
          slotData[slot.slotType]!.availableSlots++;
        }
      }
    }

    return Center(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(label: Text('Slot Type')),
          DataColumn(label: Text('Available')),
          DataColumn(label: Text('Total')),
        ],
        rows: GenericConstants.carTypes.keys
            .map(
              (slotType) => DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(
                      GenericConstants.carTypes[slotType]!,
                      style: const TextStyle(color: Colors.orange),
                    ),
                  ),
                  DataCell(
                    Text(
                      "${slotData[slotType]!.availableSlots}",
                      style: slotData[slotType]!.availableSlots > 0
                          ? const TextStyle(color: Colors.blue)
                          : const TextStyle(color: Colors.red),
                    ),
                  ),
                  DataCell(
                    Text("${slotData[slotType]!.totalSlots}"),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  void parkCar(BuildContext context, Function(String, String) callBack) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => ParkCarSelectionDialog(
        onCarTypeSelected: callBack,
      ),
    );
  }

  void parkingCard(BuildContext context,
      ReservedParkingSlotDto availableParkingSlotDto) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => ParkingArrivalReceiptDialog(
        reservedParkingSlotDto: availableParkingSlotDto,
      ),
    );
  }

  void updateParkingLot(ParkingLotResponseDto parkingLot,
      ReservedParkingSlotDto availableParkingSlotDto) {
    setState(() {
      var x = parkingLot.floors
          .where((element) => element.id == availableParkingSlotDto.floorId)
          .first;
      var y = x.parkingSlots
          .where((element) => element.id == availableParkingSlotDto.slotId)
          .first;
      y.occupied = true;
      y.numberPlate = availableParkingSlotDto.numberPlate;
      y.arrivedAt = availableParkingSlotDto.arrivedAt;
    });
  }

  Widget parkingFloorFloats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        parkFloat(Colors.blue),
      ]),
    );
  }

  Widget parkFloat(MaterialColor color) {
    return FloatingActionButton(
      onPressed: () {
        parkCar(context, (String size, String numberPlate) {
          BlocProvider.of<ParkingLotBloc>(context).add(GetParkingSlotEvent(
              parkingId: parkingLot.id, size: size, numberPlate: numberPlate));
        });
      },
      tooltip: 'Park a car',
      heroTag: null,
      backgroundColor: color,
      child: const Icon(Icons.local_parking),
    );
  }
}

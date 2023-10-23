import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/app/data/dto/request_dto.dart';

import '../../data/dto/response_dto.dart';
import '../../data/service/bloc/parking/parking_bloc.dart';
import '../../util/common_method.dart';
import '../widget/edit_text_box.dart';
import '../widget/edit_text_box_number.dart';

class AddNewParkingLotPage extends StatefulWidget {
  const AddNewParkingLotPage({Key? key, required this.callback}) : super(key: key);

  final Function(ParkingLotResponseDto) callback;

  @override
  State<AddNewParkingLotPage> createState() => _AddNewParkingLotPageState();
}

class _AddNewParkingLotPageState extends State<AddNewParkingLotPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late String parkingLotName;
  late List<FloorRequestDto> floors;
  int lastFloor = 1;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    parkingLotName = "Parking lot";
    floors = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Add parking lot"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.publish),
            onPressed: () {
              _saveParkingLot();
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ParkingLotBloc, ParkingLotState>(
        listener: (context, state) {
          if (state is CreateParkingLotLoadingState) {
            loading = true;
          } else if (state is CreateParkingLotSuccessState) {
            loading = false;
            widget.callback(state.parkingLotResponseDto);
            Navigator.of(context, rootNavigator: true).pop();

            CommonMethods.showToast(
              context: context,
              text: "Parking lot created successfully",
              seconds: 2,
            );
          } else if (state is CreateParkingLotErrorState) {
            loading = false;

            CommonMethods.showToast(
              context: context,
              text: state.error,
              seconds: 2,
            );
          }
        },
        buildWhen: (prev, curr) {
          return curr is CreateParkingLotSuccessState;
        },
        builder: (context, state) {
          return itemDetails(context);
        },
      ),
    );
  }

  Widget itemDetails(BuildContext context) {
    return (!loading)
        ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomEditTextBox(
              text: parkingLotName,
              label: "Parking name",
              callback: (e) => {parkingLotName = e},
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: floors.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(floors[index].name),
                  trailing: IconButton(
                    onPressed: () {
                      _removeFloor(index);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  onTap: () {
                    _showFloorDialog(context, floors[index], false);
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                _showFloorDialog(
                  context,
                  FloorRequestDto(
                    name: "Floor ${lastFloor++}",
                    smallSlots: 10,
                    mediumSlots: 10,
                    largeSlots: 10,
                    xlargeSlots: 10,
                  ),
                  true,
                );
              },
              child: const Text('Add Floor'),
            ),
          ],
        ),
      ),
    )
        : const Center(child: CircularProgressIndicator());
  }

  Widget _buildFloorFormField(FloorRequestDto floor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CustomEditTextBox(
          text: floor.name,
          label: "Floor name",
          callback: (e) => {floor.name = e},
        ),
        CustomEditTextBoxNumber(
          number: floor.smallSlots,
          label: 'Small Slots',
          callback: (slots) {
            floor.smallSlots = slots;
          },
        ),
        CustomEditTextBoxNumber(
          number: floor.mediumSlots,
          label: 'Medium Slots',
          callback: (slots) {
            floor.mediumSlots = slots;
          },
        ),
        CustomEditTextBoxNumber(
          number: floor.largeSlots,
          label: 'Large Slots',
          callback: (slots) {
            floor.largeSlots = slots;
          },
        ),
        CustomEditTextBoxNumber(
          number: floor.xlargeSlots,
          label: 'X-Large Slots',
          callback: (slots) {
            floor.xlargeSlots = slots;
          },
        ),
      ],
    );
  }

  void _showFloorDialog(BuildContext context, FloorRequestDto floor, bool addNew) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: (addNew)
              ? const Text("Add new floor")
              : const Text("Update floor"),
          content: _buildFloorFormField(floor),
          actions: (!addNew)
              ? [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            )
          ]
              : [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  floors.add(floor);
                });
              },
              child: const Text("Add"),
            )
          ],
        );
      },
    );
  }

  void _removeFloor(int index) {
    setState(() {
      floors.removeAt(index);
    });
  }

  void _saveParkingLot() {
    final parkingLot = ParkingLotRequestDto(name: parkingLotName, floors: floors);
    BlocProvider.of<ParkingLotBloc>(context).add(CreateParkingLotEvent(parkingLotRequestDto: parkingLot));
  }
}


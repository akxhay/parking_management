import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parking/app/data/dto/request_dto.dart';

import '../../data/dto/response_dto.dart';
import '../../data/service/parking_bloc/parking_bloc.dart';
import '../../util/common_method.dart';
import '../widget/loaders.dart';

class AddNewParkingLotPage extends StatefulWidget {
  const AddNewParkingLotPage({Key? key, required this.context})
      : super(key: key);

  final BuildContext context;

  @override
  State<AddNewParkingLotPage> createState() => _AddNewParkingLotPageState();
}

class _AddNewParkingLotPageState extends State<AddNewParkingLotPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _parkFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _floorFormKey = GlobalKey<FormState>();

  late String parkingLotName;
  late List<FloorRequestDto> floors;
  int lastFloor = 1;

  late Function(ParkingLotResponseDto) callback;

  @override
  void initState() {
    super.initState();
    callback = ModalRoute.of(widget.context)!.settings.arguments as Function(
        ParkingLotResponseDto);

    parkingLotName = "Parking lot";
    floors = [
      FloorRequestDto(
        name: "Floor ${lastFloor++}",
        smallSlots: 10,
        mediumSlots: 10,
        largeSlots: 10,
        xlargeSlots: 10,
      )
    ];
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
              if (_parkFormKey.currentState!.validate()) {
                _saveParkingLot();
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: BlocConsumer<ParkingLotBloc, ParkingLotState>(
        listener: (context, state) {
          if (state is CreateParkingLotLoadingState) {
            loadingIndicator(context, "Creating parking lot");
          } else if (state is CreateParkingLotSuccessState) {
            Navigator.pop(context); // Close the loading indicator dialog.
            callback(state.parkingLotResponseDto);
            Navigator.of(context, rootNavigator: true).pop();
            CommonMethods.showToast(
              context: context,
              text: "Parking lot created successfully",
              seconds: 2,
            );
          } else if (state is CreateParkingLotErrorState) {
            Navigator.pop(context);
            WidgetsBinding.instance.addPostFrameCallback((_) => messageDialog(
                context,
                "Failed",
                state.error)); // Close the loading indicator dialog.
          }
        },
        buildWhen: (prev, curr) => curr is CreateParkingLotSuccessState,
        builder: (context, state) => itemDetails(context),
      ),
    );
  }

  Widget itemDetails(BuildContext context) {
    return Form(
      key: _parkFormKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: parkingLotName,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: "Parking Name",
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'Enter Parking Name',
                  fillColor: Colors.white,
                  // Background color
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.grey), // Border color when not focused
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.blue), // Border color when focused
                  ),
                  labelStyle: TextStyle(
                    fontSize: 16, // Label text size
                    color: Colors.blue, // Label text color
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Invalid Parking Name';
                  }
                  return null;
                },
                onChanged: (String newValue) => parkingLotName = newValue,
                style: const TextStyle(
                  fontSize: 18, // Input text size
                  color: Colors.black, // Input text color
                  fontFamily: 'Poppins',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: floors.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(floors[index].name),
                    trailing: IconButton(
                      onPressed: () {
                        if (floors.length > 1) {
                          _removeFloor(index);
                        } else {
                          CommonMethods.showToast(
                              context: context,
                              text: "At least 1 floor is required");
                        }
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
      ),
    );
  }

  void _showFloorDialog(BuildContext context, FloorRequestDto floor, bool addNew) {
    var tempCopy = FloorRequestDto.fromJson(floor.toMap());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Form(
          key: _floorFormKey,
          child: AlertDialog(
            title: (addNew)
                ? const Text("Add new floor")
                : const Text("Update floor"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: tempCopy.name,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Floor Name",
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter floor Name',
                    fillColor: Colors.white,
                    // Background color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Border color when focused
                    ),
                    labelStyle: TextStyle(
                      fontSize: 16, // Label text size
                      color: Colors.blue, // Label text color
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Invalid floor Name';
                    }
                    return null;
                  },
                  onChanged: (String newValue) => tempCopy.name = newValue,
                  style: const TextStyle(
                    fontSize: 18, // Input text size
                    color: Colors.black, // Input text color
                    fontFamily: 'Poppins',
                  ),
                ),
                TextFormField(
                  initialValue: tempCopy.smallSlots.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Small slots (1 -999)",
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter Small slots',
                    fillColor: Colors.white,
                    // Background color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Border color when focused
                    ),
                    labelStyle: TextStyle(
                      fontSize: 16, // Label text size
                      color: Colors.blue, // Label text color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final number = int.tryParse(value);
                    if (number == null || number < 1 || number > 999) {
                      return 'Must be greater than 0';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    if (value != "" && int.tryParse(value) != null)
                      {tempCopy.smallSlots = int.parse(value)}
                  },
                ),
                TextFormField(
                  initialValue: tempCopy.mediumSlots.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Medium slots (1 -999)",
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter medium slots',
                    fillColor: Colors.white,
                    // Background color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Border color when focused
                    ),
                    labelStyle: TextStyle(
                      fontSize: 16, // Label text size
                      color: Colors.blue, // Label text color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final number = int.tryParse(value);
                    if (number == null || number < 1 || number > 999) {
                      return 'Must be greater than 0';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    if (value != "" && int.tryParse(value) != null)
                      {tempCopy.mediumSlots = int.parse(value)}
                  },
                ),
                TextFormField(
                  initialValue: tempCopy.largeSlots.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: "Large slots (1 -999)",
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter Large slots',
                    fillColor: Colors.white,
                    // Background color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Border color when focused
                    ),
                    labelStyle: TextStyle(
                      fontSize: 16, // Label text size
                      color: Colors.blue, // Label text color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final number = int.tryParse(value);
                    if (number == null || number < 1 || number > 999) {
                      return 'Must be greater than 0';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    if (value != "" && int.tryParse(value) != null)
                      {tempCopy.largeSlots = int.parse(value)}
                  },
                ),
                TextFormField(
                  initialValue: tempCopy.xlargeSlots.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
                  ],
                  decoration: const InputDecoration(
                    labelText: "X large slots (1 -999)",
                    isDense: true,
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter X large slots',
                    fillColor: Colors.white,
                    // Background color
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey), // Border color when not focused
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Border color when focused
                    ),
                    labelStyle: TextStyle(
                      fontSize: 16, // Label text size
                      color: Colors.blue, // Label text color
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    final number = int.tryParse(value);
                    if (number == null || number < 1 || number > 999) {
                      return 'Must be greater than 0';
                    }
                    return null;
                  },
                  onChanged: (String value) => {
                    if (value != "" && int.tryParse(value) != null)
                      {tempCopy.xlargeSlots = int.parse(value)}
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
              ElevatedButton(
              onPressed: () {
                  if (_floorFormKey.currentState!.validate()) {
                    // The form is valid, you can proceed with submitting.
                    Navigator.of(context).pop();
                    setState(() {
                      if (addNew) {
                        floors.add(tempCopy);
                      } else {
                        floor.name = tempCopy.name;
                        floor.smallSlots = tempCopy.smallSlots;
                        floor.mediumSlots = tempCopy.mediumSlots;
                        floor.largeSlots = tempCopy.largeSlots;
                        floor.xlargeSlots = tempCopy.xlargeSlots;
                      }
                    });
                  }
                },
                child: (addNew) ? const Text("Add") : const Text("Update"),
              )
            ],
          ),
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


import 'package:flutter/material.dart';
import 'package:parking/app/data/constants/generic_constants.dart';

class ParkCarSelectionDialog extends StatefulWidget {
  final Function(String, String) onCarTypeSelected;

  const ParkCarSelectionDialog({super.key, required this.onCarTypeSelected});

  @override
  ParkCarSelectionDialogState createState() => ParkCarSelectionDialogState();
}

class ParkCarSelectionDialogState extends State<ParkCarSelectionDialog> {
  late String selectedCarType;
  String? numberPlate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    selectedCarType =
        GenericConstants.carTypes.keys.first; // Set the default value
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: const Center(
          child: Text(
            'Park Your Car',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Car Size',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
              DropdownButton<String>(
                value: selectedCarType,
                items: GenericConstants.carTypes.keys.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      GenericConstants.carTypes[item]!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCarType = value!;
                  });
                },
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: "",
                keyboardType: TextInputType.text,
                maxLength: 8,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return 'Invalid number plate';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: "Enter Plate Number",
                  isDense: true,
                  contentPadding: EdgeInsets.all(10),
                  hintText: 'A1B2C3D4',
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
                onChanged: (String newValue) => numberPlate = newValue,
                style: const TextStyle(
                  fontSize: 18, // Input text size
                  color: Colors.black, // Input text color
                  fontFamily: 'Poppins',
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
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
              if (_formKey.currentState!.validate()) {
                Navigator.pop(context);
                widget.onCarTypeSelected(selectedCarType, numberPlate!);
              }
            },
            child: const Text(
              'Park',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

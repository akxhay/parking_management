import 'package:flutter/material.dart';
import 'package:parking/app/data/constants/generic_constants.dart';

class ParkCarSelectionDialog extends StatefulWidget {
  final Function(String) onCarTypeSelected;

  ParkCarSelectionDialog({required this.onCarTypeSelected});

  @override
  _ParkCarSelectionDialogState createState() => _ParkCarSelectionDialogState();
}

class _ParkCarSelectionDialogState extends State<ParkCarSelectionDialog> {
  late String selectedCarType;

  @override
  void initState() {
    super.initState();
    selectedCarType =
        GenericConstants.carTypes.keys.first; // Set the default value
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Park a car',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 0,
      content: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: const BoxConstraints(), // Set the maximum width
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      'Car Size',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 20),
                    DropdownButton<String>(
                      value: selectedCarType,
                      items: GenericConstants.carTypes.keys.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            GenericConstants.carTypes[item]!,
                            style: const TextStyle(
                              fontSize: 18,
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
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onCarTypeSelected(selectedCarType);
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

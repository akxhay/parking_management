import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class ParkCarView extends StatefulWidget {
  const ParkCarView({super.key, required this.callBack});

  final Function(String?) callBack;

  @override
  State<ParkCarView> createState() => _ParkCarViewState();
}

class _ParkCarViewState extends State<ParkCarView> {
  int selectedCarTypeIndex = 0;
  int numberPlate = 0;
  late List<String> carTypes;

  @override
  void initState() {
    super.initState();
    carTypes = List.empty(growable: true);
    carTypes.add("s");
    carTypes.add("m");
    carTypes.add("l");
    carTypes.add("xl");
  }

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> menuItems = [];
    for (var item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 100,
                  child: Text(
                    "Car type: ",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                DropdownButtonHideUnderline(
                    child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                  items: _addDividersAfterItems(carTypes),
                  value: carTypes[0],
                  onChanged: (value) {
                    setState(() {
                      selectedCarTypeIndex = carTypes
                          .indexWhere((element) => element == value as String);
                      widget.callBack(value);
                    });
                  },
                  buttonStyleData:
                      const ButtonStyleData(height: 40, width: 140),
                  dropdownStyleData: const DropdownStyleData(
                    maxHeight: 200,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

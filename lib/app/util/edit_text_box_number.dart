import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomEditTextBoxNumber extends StatefulWidget {
  const CustomEditTextBoxNumber({
    Key? key,
    required this.number,
    required this.label,
    required this.callback,
  }) : super(key: key);
  final int number;
  final String label;
  final Function(int) callback;
  @override
  CustomEditTextBoxNumberState createState() => CustomEditTextBoxNumberState();
}

class CustomEditTextBoxNumberState extends State<CustomEditTextBoxNumber> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.number.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListTile(
            title: TextFormField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}')),
              ],
              decoration: InputDecoration(
                labelText: "${widget.label} (1 - 999)",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a number';
                }
                final number = int.tryParse(value);
                if (number == "" ||
                    number == null ||
                    number < 1 ||
                    number > 999) {
                  return 'Please enter a number between 1 and 999';
                }
                return null;
              },
              onChanged: (String value) => {
                if (value != "" && int.tryParse(value) != null)
                  {widget.callback(int.parse(value))}
              },
            ),
          ),
        ));
  }
}

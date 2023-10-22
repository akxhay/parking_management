import 'package:flutter/material.dart';

class CustomEditTextBox extends StatelessWidget {
  final String text;
  final String label;
  final Function(String) callback;
  final bool readOnly;
  final Widget? leading;
  final Widget? trailing;

  const CustomEditTextBox({
    Key? key,
    required this.text,
    required this.label,
    required this.callback,
    this.readOnly = false,
    this.leading,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.white,
        key: ValueKey(text),
        elevation: 2,
        child: ListTile(
          leading: leading,
          trailing: trailing,
          title: TextFormField(
            initialValue: text,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 20,
            readOnly: readOnly,
            decoration: InputDecoration(
              labelText: label,
              isDense: true,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(10),
              hintText: 'Enter $label',
              fillColor: Colors.black,
            ),
            onChanged: (String newValue) => callback(newValue),
            style: TextStyle(
              color: readOnly ? Colors.grey : Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CommonMethods {
  static void showToast(
      {required BuildContext context, required String text, int seconds = 2}) {
    final ScaffoldMessengerState scaffold = ScaffoldMessenger.of(context);

    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds: seconds),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

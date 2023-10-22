import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Platform.isIOS
          ? const CupertinoAlertDialog(
              title: Text(
                "Loading...",
                style: TextStyle(fontSize: 20),
              ),
              content: CupertinoActivityIndicator(radius: 13.0),
            )
          : const AlertDialog(
              title: Center(
                child: Text(
                  "Loading...",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                ],
              ),
            ),
    );
  }
}

void loadingIndicator(BuildContext context, String title) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Platform.isIOS
              ? CupertinoAlertDialog(
                  title: Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  content: const CupertinoActivityIndicator(radius: 13.0),
                )
              : AlertDialog(
                  title: Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  content: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
        );
      });
}

void messageDialog(BuildContext context, String title, String message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                content: Text(message),
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Center(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                content: Text(message),
                actions: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  )
                ],
              );
      });
}

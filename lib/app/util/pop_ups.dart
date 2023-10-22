import 'package:flutter/material.dart';

class CbPopUps {
  static void showGenericDialog({
    required BuildContext context,
    required Widget widget,
    String label = 'Edit text group',
    double? dialogWidth,
    double? maxDialogHeight,
    bool barrierDismissible = true,
    Color barrierColor = const Color.fromRGBO(0, 0, 0, 0.5),
    Duration transitionDuration = const Duration(milliseconds: 400),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20)),
    String dismissButtonLabel = 'Dismiss',
    VoidCallback? customDismissAction,
  }) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      transitionDuration: transitionDuration,
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      dialogWidth ?? MediaQuery.of(context).size.width * .9,
                  maxHeight: maxDialogHeight ??
                      MediaQuery.of(context).size.height * .7,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 16),
                        widget,
                        TextButton(
                          onPressed: () {
                            if (customDismissAction != null) {
                              customDismissAction();
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            dismissButtonLabel,
                            style: const TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

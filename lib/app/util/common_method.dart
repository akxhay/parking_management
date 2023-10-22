import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonMethods {
  static final _formKey = GlobalKey<FormState>();

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

  static Widget listItemText({required String title, String? subtitle}) {
    return ListTile(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: ExpandableText(
          (subtitle != null) ? subtitle : "",
          expandText: 'show more',
          collapseText: 'show less',
          maxLines: 5,
          linkColor: Colors.blue,
          style: const TextStyle(color: Colors.black87),
        ));
  }

  static Widget customFormTextView(
      {required BuildContext context,
      required text,
      required label,
      required callback,
      readOnly = false,
      leading,
      trailing}) {
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
                  maxLines: 8,
                  readOnly: readOnly,
                  decoration: InputDecoration(
                    labelText: label,
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Enter $label',
                    fillColor: Colors.black,

                    //fillColor: Colors.green
                  ),
                  onChanged: (String newValue) => callback(newValue),
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  )),
            )));
  }

  static Widget listItemList({
    required BuildContext context,
    required String title,
    required List<String> subtitle,
    required Function(List<String>) callback,
  }) {
    return Card(
      color: Colors.white,
      key: ValueKey(title),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
        child: GestureDetector(
          onTap: () {
            openPopupEditBox(
                context,
                subtitle.join("\n\n"),
                "Text",
                (String input) => {
                      callback(
                          input.split("\n\n").map((e) => e.trim()).toList())
                    },
                "Update text",
                null);
          },
          child: ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              subtitle: ExpandableText(
                subtitle.join("\n"),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 5,
                linkColor: Colors.blue,
                style: const TextStyle(color: Colors.black87),
              )),
        ),
      ),
    );
  }

  static void showTextAlert(BuildContext context, List<String> text) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Text',
                style: TextStyle(color: Colors.orange),
              ),
              content: Container(
                constraints: BoxConstraints(
                  maxHeight: 500,
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[for (var item in text) Text(item)],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Okay'),
                  child: const Text(
                    'Okay',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ));
  }

  static void openPopupEditBoxWithDefaultAlert(
      BuildContext context,
      String text,
      String type,
      Function(String) callback,
      String? title,
      String? positiveButton) {
    String changedValue = text;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          title ?? type,
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 14,
          ),
        ),
        content: Card(
          color: Colors.white,
          elevation: 2,
          shadowColor: Colors.green,
          child: TextFormField(
            initialValue: text,
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 50,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(10),
              hintText: 'Enter $type',
              fillColor: Colors.white,
            ),
            onChanged: (String newValue) {
              changedValue = newValue;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              if (changedValue == "") {
                CommonMethods.showToast(
                    context: context, text: "$type cannot be blank");
              } else {
                callback(changedValue);
                Navigator.pop(context, 'OK');
              }
            },
            child: Text(
              positiveButton ?? 'Update',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void openPopupEditBox(BuildContext context, String text, String type,
      Function(String) callback, String? title, String? positiveButton) {
    String changedValue = text;
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.center,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width * .9,
              height: MediaQuery.of(context).size.height *
                  .6, // Change as per your requirement
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        title ?? "alert",
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      shadowColor: Colors.green,
                      child: TextFormField(
                        initialValue: text,
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 15,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(10),
                          hintText: 'Enter $type',
                          fillColor: Colors.white,
                        ),
                        onChanged: (String newValue) {
                          changedValue = newValue;
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        TextButton(
                          onPressed: () async {
                            if (changedValue == "") {
                              CommonMethods.showToast(
                                  context: context,
                                  text: "$type cannot be blank");
                            } else {
                              callback(changedValue);
                              Navigator.pop(context, 'OK');
                            }
                          },
                          child: Text(
                            positiveButton ?? 'Update',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void openPopupMultipleEditBoxNumber(
    BuildContext context,
    List<int> input,
    List<String> name,
    String title,
    String? positiveButton,
    TextInputType? textInputTypes,
    Function(int, int, List<int>) validator,
    Function(List<int>) callback,
  ) {
    List<int> changedValue = List.of(input);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // Wrap the content of the column
                children: input.asMap().entries.map((e) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      initialValue: e.value.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      keyboardType: textInputTypes,
                      inputFormatters: <TextInputFormatter>[
                        if (textInputTypes != null)
                          FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: (value) {
                        String? validated =
                            validator(int.parse(value!), e.key, changedValue);
                        if (validated != null) {
                          return validated;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: name[e.key],
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        contentPadding: const EdgeInsets.all(15),
                        hintText: 'Enter ${name[e.key]}',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.grey[100],
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                        ),
                      ),
                      onChanged: (String newValue) {
                        changedValue[e.key] = int.parse(newValue);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  callback(changedValue);
                  Navigator.pop(context, 'OK');
                }
              },
              style: TextButton.styleFrom(
                visualDensity: VisualDensity.compact,
              ),
              child: Text(
                positiveButton ?? 'Update',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        );
      },
    );

    //   AlertDialog(
    //     backgroundColor: Colors.white,
    //     title: Text(
    //       title,
    //       style: const TextStyle(
    //         color: Colors.blue,
    //         fontSize: 14,
    //       ),
    //     ),
    //     content: SingleChildScrollView(
    //       // allows for scrolling
    //       child: ConstrainedBox(
    //         // constrain the maximum height
    //         constraints: BoxConstraints(
    //             maxHeight: MediaQuery.of(context).size.height *
    //                 0.2), // use half the screen height
    //
    //         child: Card(
    //           elevation: 5,
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(15),
    //           ),
    //           clipBehavior: Clip.antiAlias,
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: text.asMap().entries.map((e) {
    //                 return Column(
    //                   children: <Widget>[
    //                     Container(
    //                       margin: const EdgeInsets.only(bottom: 10),
    //                       child: TextFormField(
    //                         initialValue: e.value,
    //                         style: const TextStyle(
    //                           color: Colors.white,
    //                           fontSize: 18,
    //                         ),
    //                         decoration: InputDecoration(
    //                           isDense: true,
    //                           contentPadding: const EdgeInsets.all(15),
    //                           hintText: 'Enter ${type[e.key]}',
    //                           hintStyle: const TextStyle(color: Colors.white70),
    //                           filled: true,
    //                           fillColor: Colors.white24,
    //                           enabledBorder: const OutlineInputBorder(
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(5.0)),
    //                             borderSide:
    //                                 BorderSide(color: Colors.white70, width: 2),
    //                           ),
    //                           focusedBorder: const OutlineInputBorder(
    //                             borderRadius:
    //                                 BorderRadius.all(Radius.circular(5.0)),
    //                             borderSide:
    //                                 BorderSide(color: Colors.white, width: 2),
    //                           ),
    //                         ),
    //                         onChanged: (String newValue) {
    //                           changedValue[e.key] = newValue;
    //                         },
    //                       ),
    //                     ),
    //                     const Divider(color: Colors.white),
    //                   ],
    //                 );
    //               }).toList(),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //     actions: <Widget>[
    //       TextButton(
    //         onPressed: () => Navigator.pop(context, 'Cancel'),
    //         child: const Text(
    //           'Cancel',
    //           style: TextStyle(
    //             color: Colors.black,
    //             fontSize: 14,
    //           ),
    //         ),
    //       ),
    //       TextButton(
    //         onPressed: () async {
    //           if (changedValue.any((element) => element.isEmpty)) {
    //             CommonMethods.showToast(
    //                 context: context, text: "$type cannot be blank");
    //           } else {
    //             callback(changedValue);
    //             Navigator.pop(context, 'OK');
    //           }
    //         },
    //         child: Text(
    //           positiveButton ?? 'Update',
    //           style: const TextStyle(
    //             color: Colors.green,
    //             fontSize: 14,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

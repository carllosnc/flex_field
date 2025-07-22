library;

import 'package:flutter/material.dart';

typedef Label = Widget Function();
typedef Filled = Widget Function(String value);

extension FlexFieldExtension on TextFormField {
  flex({
    required BuildContext context,
    required Label label,
    required Filled filled,
    required String name,
    String resetText = "Reset",
    String okText = "OK",
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        final currentValue = controller!.text;
        String? isValid;

        return Material(
          child: InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, insideSetState) {
                      return AlertDialog(
                        title: Text(name),
                        content: Column(
                          spacing: 5,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            this,
                            if (isValid != null)
                              Text(
                                isValid!,
                                style: const TextStyle(color: Colors.red),
                              ),
                          ],
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () {
                              controller!.text = "";
                              setState(() {});
                            },
                            child: Text(resetText),
                          ),
                          FilledButton(
                            onPressed: () {
                              insideSetState(() {
                                isValid = validator!(controller!.text);
                              });

                              if (validator!(controller!.text) == null) {
                                Navigator.pop(context);
                                setState(() {});
                              }
                            },
                            child: Text(okText),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              child: currentValue.isEmpty ? label() : filled(currentValue),
            ),
          ),
        );
      },
    );
  }
}

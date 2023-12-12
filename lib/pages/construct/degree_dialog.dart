import 'package:enthrirhs/libs/ithkuil/terms/mod.dart';
import 'package:flutter/material.dart';

Future<Degree?> showDegreeDialog(BuildContext context, Degree initialValue) {
  return showDialog<Degree>(
    context: context,
    builder: (context) {
      Degree selectedValue = initialValue;
      ScrollController scrollController = ScrollController();
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Change Degree"),
          content: SizedBox(
            width: 320,
            height: 320,
            child: Scrollbar(
              controller: scrollController,
              child: ListView(
                // mainAxisSize: MainAxisSize.min,
                controller: scrollController,
                children: [
                  {
                    "value": Degree.d1,
                    "title": "Degree 1",
                  },
                  {
                    "value": Degree.d2,
                    "title": "Degree 2",
                  },
                  {
                    "value": Degree.d3,
                    "title": "Degree 3",
                  },
                  {
                    "value": Degree.d4,
                    "title": "Degree 4",
                  },
                  {
                    "value": Degree.d5,
                    "title": "Degree 5",
                  },
                  {"value": Degree.d6, "title": "Degree 6"},
                  {
                    "value": Degree.d7,
                    "title": "Degree 7",
                  },
                  {
                    "value": Degree.d8,
                    "title": "Degree 8",
                  },
                  {
                    "value": Degree.d9,
                    "title": "Degree 9",
                  },
                  {
                    "value": Degree.d0,
                    "title": "Degree 0",
                  },
                ].map((e) {
                  final Degree value = e['value'] as Degree;
                  final String title = e['title'] as String;
                  return RadioListTile(
                    value: value,
                    groupValue: selectedValue,
                    title: Text(title),
                    onChanged: (degree) {
                      if (degree != null) {
                        setState(() {
                          selectedValue = degree;
                        });
                      }
                    },
                  );
                }).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, selectedValue);
              },
              child: const Text("Ok"),
            )
          ],
        ),
      );
    },
  );
}

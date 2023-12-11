import 'package:enthrirhs/libs/ithkuil/terms/affix_type.dart';
import 'package:flutter/material.dart';

Future<AffixType?> showAffixTypeDialog(BuildContext context, AffixType initialValue) {
  return showDialog<AffixType>(
    context: context,
    builder: (context) {
      AffixType selectedValue = initialValue;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text("Change Affix Type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                value: AffixType.type1,
                groupValue: selectedValue,
                title: const Text("Type 1"),
                onChanged: (affixType) {
                  if (affixType != null) {
                    setState(() {
                      selectedValue = affixType;
                    });
                  }
                },
              ),
              RadioListTile(
                value: AffixType.type2,
                groupValue: selectedValue,
                title: const Text("Type 2"),
                onChanged: (affixType) {
                  if (affixType != null) {
                    setState(() {
                      selectedValue = affixType;
                    });
                  }
                },
              ),
              RadioListTile(
                value: AffixType.type3,
                groupValue: selectedValue,
                title: const Text("Type 3"),
                onChanged: (affixType) {
                  if (affixType != null) {
                    setState(() {
                      selectedValue = affixType;
                    });
                  }
                },
              )
            ],
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

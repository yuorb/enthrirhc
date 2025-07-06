import 'package:enthrirhc/libs/misc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../libs/ithkuil/writing/mod.dart';

class IthkuilSvg extends StatelessWidget {
  final List<Character> characters;

  const IthkuilSvg(this.characters, {super.key});

  @override
  Widget build(BuildContext context) {
    final String fillColor = colorToHex(
      Theme.of(context).textTheme.titleLarge!.color!,
    );
    final String staffColor =
        MediaQuery.of(context).platformBrightness == Brightness.light
        ? "#cccccc"
        : "#333333";

    final rawSvg = _generate(characters, fillColor, staffColor);
    return SvgPicture.string(rawSvg, height: 160);
  }

  String _generate(
    List<Character> characters,
    String fillColor,
    String staffColor,
  ) {
    return ithkuilWriting(
      characters,
      fillColor: fillColor,
      staffColor: staffColor,
    ).$1;
  }
}

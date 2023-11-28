import 'package:enthrirch/libs/misc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../libs/ithkuil/writing/mod.dart';

class IthkuilSvg extends StatelessWidget {
  final List<Character> characters;

  const IthkuilSvg(this.characters, {super.key});

  @override
  Widget build(BuildContext context) {
    final String fillColor = colorToHex(Theme.of(context).textTheme.titleLarge!.color!);
    // final String fillColor = "#e6e1e6";

    return SvgPicture.string(
      _generate(characters, fillColor),
      width: MediaQuery.of(context).size.width - 32,
    );
  }

  String _generate(List<Character> characters, String fillColor) {
    return ithkuilWriting(characters, fillColor);
  }
}

import 'dart:math';

import 'package:enthrirhs/libs/ithkuil/writing/primary/mod.dart';

import '../utils.dart';

(double, double) getPrimaryBoundary(Primary primary) {
  final componentAPath = primary.componentA().path();
  final componentBPath = primary.componentB().path();
  final componentCPath = primary.componentC().path();
  final componentDPath = primary.componentD().path();
  final (coreLeft, coreRight) = getCoreBoundary(primary.specification.path());
  final (componentALeft, componentARight) = getExtensionBoundary(componentAPath);
  final (componentBLeft, componentBRight) = getExtensionBoundary(componentBPath);
  final (componentCLeft, componentCRight) = getExtensionBoundary(componentCPath);
  final (componentDLeft, componentDRight) = getExtensionBoundary(componentDPath);

  final left = [
    coreLeft,
    primary.specification.centerX() + componentALeft,
    primary.specification.bAnchor().x + componentBLeft,
    primary.specification.centerX() + componentCLeft,
    primary.specification.dAnchor().x + componentDLeft,
  ].reduce(min);
  final right = [
    coreRight,
    primary.specification.centerX() + componentARight,
    primary.specification.bAnchor().x + componentBRight,
    primary.specification.centerX() + componentCRight,
    primary.specification.dAnchor().x + componentDRight,
  ].reduce(max);

  return (left, right);
}

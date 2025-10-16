import 'dart:math' as math;

import 'package:flutter/material.dart';

class EthosGradientTheme {
  EthosGradientTheme._();

  static const Duration animationDuration = Duration(milliseconds: 1800);
  static const Curve animationCurve = Curves.easeInOut;

  static LinearGradient gradientForType(String type) {
    final _GradientSpec spec =
        _gradientMap[type] ?? _gradientMap[_defaultKey]!;
    return LinearGradient(
      colors: spec.colors,
      begin: AlignmentDirectional.topStart,
      end: AlignmentDirectional.bottomEnd,
      transform: GradientRotation(_degreesToRadians(spec.angleDegrees)),
    );
  }

  static double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  static const String _defaultKey = 'Tourism';

  static const Map<String, _GradientSpec> _gradientMap = <String, _GradientSpec>{
    'Tourism': _GradientSpec(
      colors: <Color>[Color(0xFF4AC6E7), Color(0xFF2E7BCB)],
      angleDegrees: 35,
    ),
    'Volunteer': _GradientSpec(
      colors: <Color>[Color(0xFF38B16E), Color(0xFFFF8C42)],
      angleDegrees: 15,
    ),
    'Learning': _GradientSpec(
      colors: <Color>[Color(0xFF7C4DFF), Color(0xFF00BCD4)],
      angleDegrees: 60,
    ),
    'Private': _GradientSpec(
      colors: <Color>[Color(0xFFF7B733), Color(0xFF1E3C72)],
      angleDegrees: 90,
    ),
    'Scientific': _GradientSpec(
      colors: <Color>[Color(0xFF00C9FF), Color(0xFF005BEA)],
      angleDegrees: 45,
    ),
    'Cultural': _GradientSpec(
      colors: <Color>[Color(0xFFB24592), Color(0xFFF15F79)],
      angleDegrees: 20,
    ),
    'Hiking': _GradientSpec(
      colors: <Color>[Color(0xFF2EBF91), Color(0xFF8360C3)],
      angleDegrees: 30,
    ),
    'Camping': _GradientSpec(
      colors: <Color>[Color(0xFF3CA55C), Color(0xFFB5AC49)],
      angleDegrees: 10,
    ),
  };
}

class _GradientSpec {
  const _GradientSpec({required this.colors, required this.angleDegrees});

  final List<Color> colors;
  final double angleDegrees;
}

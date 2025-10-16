import 'package:flutter/material.dart';

import '../core/theme/gradient_theme.dart';

class AnimatedGradientBackground extends StatelessWidget {
  const AnimatedGradientBackground({
    super.key,
    required this.type,
    required this.child,
  });

  final String type;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final LinearGradient gradient = EthosGradientTheme.gradientForType(type);
    return AnimatedContainer(
      duration: EthosGradientTheme.animationDuration,
      curve: EthosGradientTheme.animationCurve,
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(gradient: gradient),
      child: child,
    );
  }
}

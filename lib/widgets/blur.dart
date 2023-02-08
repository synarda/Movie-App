import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';

class Blur extends StatelessWidget {
  const Blur({
    Key? key,
    required this.child,
    this.overlay,
    this.blur = 5,
  }) : super(key: key);

  final Widget child;
  final Widget? overlay;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          child,
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colorss.background.withOpacity(0.5),
                ),
                child: overlay,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

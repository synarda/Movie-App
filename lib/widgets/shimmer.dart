import 'package:flutter/material.dart';
import 'package:provider_api/utils/const.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({
    super.key,
    required this.child,
    required this.active,
    this.radius = 0,
  });
  final Widget child;
  final double radius;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return active
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Stack(
              children: [
                child,
                Positioned.fill(
                  child: Shimmer.fromColors(
                    period: const Duration(milliseconds: 1500),
                    baseColor: Colors.transparent,
                    highlightColor: Colorss.textColor.withOpacity(0.4),
                    child: Container(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          )
        : child;
  }
}

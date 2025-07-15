import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNewsCard extends StatelessWidget {
  final bool isWide;
  const ShimmerNewsCard({super.key, this.isWide = false});

  @override
  Widget build(BuildContext context) {
    final width = isWide ? 240.0 : 180.0;
    final height = isWide ? 180.0 : 140.0;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

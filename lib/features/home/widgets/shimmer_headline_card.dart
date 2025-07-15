import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerHeadlineCard extends StatelessWidget {
  final bool isWide;
  const ShimmerHeadlineCard({super.key, this.isWide = false});

  @override
  Widget build(BuildContext context) {
    final imageHeight = isWide ? 130.0 : 90.0;
    final imageWidth = isWide ? 160.0 : 110.0;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Container(
              height: imageHeight,
              width: imageWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 16, color: Colors.white),
                  const SizedBox(height: 8),
                  Container(height: 14, color: Colors.white),
                  const SizedBox(height: 6),
                  Container(height: 12, width: 80, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

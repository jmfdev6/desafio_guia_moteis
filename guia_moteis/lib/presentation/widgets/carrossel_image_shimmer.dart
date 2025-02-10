import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerImageCarousel extends StatelessWidget {
  const ShimmerImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Define uma altura aproximada igual à que você usa no carousel real
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 200, // ajuste conforme necessário
        width: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

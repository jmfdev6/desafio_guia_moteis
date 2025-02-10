import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMotelCard extends StatelessWidget {
  const ShimmerMotelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
        ),
      ),
      title: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 100,
          height: 16,
          color: Colors.white,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: 150,
            height: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

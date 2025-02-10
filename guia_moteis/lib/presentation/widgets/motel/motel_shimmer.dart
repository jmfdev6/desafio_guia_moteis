import 'package:flutter/material.dart';
import 'package:guia_moteis/presentation/widgets/suites/card_suit_shimmer.dart';
import 'package:guia_moteis/presentation/widgets/carrossel_image_shimmer.dart';
import 'package:guia_moteis/presentation/widgets/motel/motel_card_shimmer.dart';



class MoteisScreenShimmer extends StatelessWidget {
  const MoteisScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return ListView.builder(
      itemCount: 6, // Número de placeholders para simular a lista
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(
              height: 14,
              color: Color(0xFFF0F0F0),
              thickness: 10,
            ),
            const ShimmerMotelCard(),
            const SizedBox(height: 2),
            Container(
              height: screenHeight * 0.8,
              margin: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: const [
                  ShimmerImageCarousel(),
                  SizedBox(height: 10),
                  ShimmerCardSuit(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

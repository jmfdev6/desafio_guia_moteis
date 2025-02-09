import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SuitesScreenShimmer extends StatelessWidget {
  const SuitesScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Cabeçalho: simula o nome da suíte e botões de navegação
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                width: 200,
                height: 20,
                color: Colors.white,
              ),
            ),
          ),
          // Placeholder para o ImageCarousel
          Expanded(
            flex: 5,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // Placeholder para o CardSuit (dados da suíte: categorias, preços, etc.)
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

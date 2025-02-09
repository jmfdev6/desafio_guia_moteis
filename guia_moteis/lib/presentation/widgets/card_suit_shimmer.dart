import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCardSuit extends StatelessWidget {
  const ShimmerCardSuit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Usamos uma coluna para imitar a estrutura do CardSuit
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          // Linha com os círculos (categoria)
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Título "Preços e periodos"
          Container(
            width: 150,
            height: 16,
            color: Colors.white,
          ),
          const SizedBox(height: 8),
          // Simulação da tabela: 3 linhas e 4 colunas
          Column(
            children: List.generate(3, (row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (col) {
                    return Container(
                      width: 50,
                      height: 16,
                      color: Colors.white,
                    );
                  }),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

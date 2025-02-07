import 'package:flutter/material.dart';
import 'package:guia_moteis/models/moteis_model.dart';
import 'package:guia_moteis/view/suites/widgts/card_suit.dart';
import 'package:guia_moteis/view/suites/widgts/carrossel_image.dart';

class SuitesScreen extends StatelessWidget {
  final List<Suites>? suites;
  final List<String> imageUrls;

  const SuitesScreen({super.key, required this.suites, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    if (suites == null || suites!.isEmpty) {
      return const Center(child: Text("Nenhuma suíte encontrada"));
    }
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: suites!.length,
      itemBuilder: (context, index) {
        final suite = suites![index];
        return Column(
          children: [
            // Carrossel de imagens da suíte – ocupa 60% da altura disponível
            Expanded(
              flex: 4,
              child: ImageCarousel(imageUrls: suite.fotos ?? [], suites: suite.nome ?? "",),
            ),
            SizedBox(height: 10,),
            // CardSuit com os dados da suíte – ocupa 40% da altura disponível
            Expanded(
              flex: 4,
              child: CardSuit(
                imageUrls: suite.fotos ?? [],
                title: suite.nome ?? "Sem nome",
                description: suite.itens ?? [],
                price: suite.periodos ?? [],
                categoriaItens: suite.categoriaItens ?? [],
              ),
            ),
          ],
        );
      },
    );
  }
}

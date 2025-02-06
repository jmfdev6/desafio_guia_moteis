import 'package:flutter/material.dart';
import 'package:guia_moteis/models/moteis_model.dart';
import 'package:guia_moteis/view/suites/widgts/card_suit.dart';
import 'package:guia_moteis/view/suites/widgts/carrossel_image.dart';

class SuitesScreen extends StatelessWidget {
  final List<String> imageUrls;
  final List<Suites> suites;

  const SuitesScreen(
    this.suites, {
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        primary: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: suites.length,
          itemBuilder: (context, index) {
            final suite = suites[index];
            return Stack(
              children: [
                Positioned.fill(child: ImageCarousel(imageUrls: suite.fotos!)),
                Positioned(
                  left: 4,
                  right: 4,
                  top: 50,
                  child: CardSuit(
                    imageUrls: suite.fotos!,
                    title: suite.nome!,
                    description: suite.itens!,
                    price: suite.periodos!,
                    rating: suite.qtd!,
                    reviewCount: suite.qtd!,
                    categoriaItens: suite.categoriaItens!,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

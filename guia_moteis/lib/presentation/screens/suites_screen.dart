import 'package:flutter/material.dart';
import 'package:guia_moteis/domain/entities/suite_entity.dart';
import 'package:guia_moteis/presentation/widgets/card_suit.dart';
import 'package:guia_moteis/presentation/widgets/carrossel_image.dart';

class SuitesScreen extends StatefulWidget {
  final List<SuiteEntity>? suites;
  final List<String> imageUrls;

  const SuitesScreen({
    super.key,
    required this.suites,
    required this.imageUrls,
  });

  @override
  State<SuitesScreen> createState() => _SuitesScreenState();
}

class _SuitesScreenState extends State<SuitesScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.suites == null || widget.suites!.isEmpty) {
      return const Center(child: Text("Nenhuma suíte encontrada"));
    }

    return Scaffold(
      body: Column(
        children: [

          Positioned(
            bottom: 20,
            right: 10,
            left: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(widget.suites![_currentPage].nome, style: TextStyle( fontWeight: FontWeight.bold, color: Color(0xFF555658)),)
              ),
              Expanded(child: Container()),
              if (_currentPage >= 0)
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF656565), size: 18,),
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),

              // Ícone de navegação para a direita
              if (_currentPage <= widget.suites!.length - 1)
                IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Color(0xFF656565), size: 18,),
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
            ],
          )),
        
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: widget.suites!.length,
                  itemBuilder: (context, index) {
                    final suite = widget.suites![index];
                    return ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      child: ImageCarousel(
                        imageUrls: suite.fotos,
                        suites: suite.qtd,
                      ),
                    );
                  },
                ),
                // Ícone de navegação para a esquerda
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: CardSuit(
                imageUrls: widget.suites![_currentPage].fotos,
                title: widget.suites![_currentPage].nome,
                description: widget.suites![_currentPage].itens,
                price: widget.suites![_currentPage].periodos,
                categoriaItens: widget.suites![_currentPage].categoriaItens,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

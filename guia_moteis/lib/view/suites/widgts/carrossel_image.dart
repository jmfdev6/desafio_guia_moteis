import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/view_model/carrossel_viewmodel.dart';
import 'package:provider/provider.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imageUrls;

  const ImageCarousel({super.key, required this.imageUrls});

  @override
  Widget build(BuildContext context) {
    final carouselViewModel = Provider.of<CarouselViewModel>(context);
    return SizedBox.expand( // Ocupa toda a área disponível
      child: Stack(
        children: [
          CarouselSlider(
            items: imageUrls.map((url) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(url),
                    fit: BoxFit.cover, // Cobrir toda a área
                  ),
                ),
              );
            }).toList(),
            carouselController: carouselViewModel.controller,
            options: CarouselOptions(
              height: double.infinity, // Altura total
              viewportFraction: 1.0,
              autoPlay: true,
              enableInfiniteScroll: true,
              onPageChanged: (index, reason) {
                carouselViewModel.updateIndex(index);
              },
            ),
          ),
          Positioned(
            bottom: 8 , // Posiciona os indicadores na parte inferior
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageUrls.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => carouselViewModel.controller.animateToPage(entry.key),
                  child: Container(
                    width: 10.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: carouselViewModel.currentIndex == entry.key
                          ? Colors.purple
                          : Colors.black12,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
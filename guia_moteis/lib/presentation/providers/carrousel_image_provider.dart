import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class CarrouselImageProvider extends ChangeNotifier {
final CarouselSliderController controller = CarouselSliderController();

  int currentIndex = 0;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
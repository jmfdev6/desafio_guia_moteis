import 'package:flutter/material.dart';
import '../models/moteis_model.dart';
import '../services/moteis_service.dart';


class MoteisViewModel extends ChangeNotifier {
  final MoteisService _moteisService = MoteisService(); 
  MoteisModel? moteisModel;
  bool isLoading = false;

  Future<void> loadMoteis() async {
    isLoading = true;
    notifyListeners();

    try {
      moteisModel = (await _moteisService.fetchMoteis()); 
    } catch (e) {
      print("Erro ao carregar os motéis: $e");
    }

    isLoading = false;
    notifyListeners();
  }
}


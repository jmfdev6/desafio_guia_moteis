import 'package:flutter/material.dart';
import '../../domain/entities/moteis_entity.dart';
import '../../domain/usecases/get_moteis.dart';

class MoteisProvider extends ChangeNotifier {
  final GetMoteis getMoteisUseCase;

  MoteisEntity? moteis;
  bool isLoading = false;
  String? errorMessage;

  MoteisProvider({required this.getMoteisUseCase});

  Future<void> loadMoteis() async {
    isLoading = true;
    notifyListeners();

    try {
      moteis = await getMoteisUseCase();
      errorMessage = null;
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

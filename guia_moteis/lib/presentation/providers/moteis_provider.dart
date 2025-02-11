import 'package:flutter/material.dart';
import '../../domain/entities/moteis_entity.dart'; // Importe sua entidade
import '../../domain/usecases/get_moteis.dart';

class MoteisProvider extends ChangeNotifier {
  final GetMoteisUseCase getMoteisUseCase;

  MoteisEntity? moteis; 
  bool isLoading = false;
  String? errorMessage; 

  MoteisProvider({required this.getMoteisUseCase});

  Future<void> loadMoteis() async {
    isLoading = true;
    notifyListeners();

    try {
      moteis = await getMoteisUseCase.execute();

      if (moteis == null || moteis!.data.moteis.isEmpty) { // Verifique a estrutura correta
        errorMessage = "Nenhum dado disponível.";
      } else {
        errorMessage = null;
      }
    } catch (error) {
      errorMessage = error.toString(); // Ou uma mensagem mais genérica
      moteis = null; 
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
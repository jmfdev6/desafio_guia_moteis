import 'package:flutter/material.dart';
import 'package:guia_moteis/presentation/providers/motel_list_provider.dart';
import 'package:guia_moteis/presentation/screens/motel_screen.dart';
import 'package:provider/provider.dart';
import 'data/services/moteis_api_service.dart';
import 'data/repositories/moteis_repository_impl.dart';
import 'domain/usecases/get_moteis.dart';

void main() {
  // Crie as dependências
  final apiService = MoteisApiService(baseUrl: "https://api.npoint.io/3e582bab936df79f08a5");
  final repository = MoteisRepositoryImpl(apiService: apiService);
  final getMoteisUseCase = GetMoteis(repository);

  runApp(MyApp(getMoteisUseCase: getMoteisUseCase));
}

class MyApp extends StatelessWidget {
  final GetMoteis getMoteisUseCase;

  const MyApp({super.key, required this.getMoteisUseCase});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MoteisProvider>(
      create: (_) => MoteisProvider(getMoteisUseCase: getMoteisUseCase)
        ..loadMoteis(),
      child: MaterialApp(
        title: 'Motéis App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MoteisScreen(),
      ),
    );
  }
}

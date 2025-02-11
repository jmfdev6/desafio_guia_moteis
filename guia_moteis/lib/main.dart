import 'package:flutter/material.dart';
import 'package:guia_moteis/dependency_injection.dart';
import 'package:guia_moteis/domain/usecases/get_moteis.dart';
import 'package:guia_moteis/presentation/providers/moteis_provider.dart';
import 'package:guia_moteis/presentation/screens/motel_screen.dart';
import 'package:provider/provider.dart';

void main() {
  setupServiceLocator(); // Inicialize o service locator
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guia de Motéis',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<MoteisProvider>(
        create: (context) => MoteisProvider(
          getMoteisUseCase: getIt<GetMoteisUseCase>(), // Injete o use case
        ),
        child: const MoteisScreen(),
      ),
    );
  }
}
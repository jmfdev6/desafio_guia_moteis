import 'package:flutter/material.dart';
import 'package:guia_moteis/domain/usecases/get_moteis.dart';
import 'package:guia_moteis/presentation/providers/carrousel_image_provider.dart';
import 'package:provider/provider.dart';

import 'dependency_injection.dart'; // Importa o arquivo que criamos
import 'presentation/providers/motel_list_provider.dart';
import 'presentation/screens/motel_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies(); // Inicializa as dependências
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MoteisProvider>(
          create: (_) => MoteisProvider(
            getMoteisUseCase: getIt<GetMoteis>(), // Recupera a instância do GetMoteis
          )..loadMoteis(), // Chama o método para carregar os dados
        ),
          ChangeNotifierProvider<CarrouselImageProvider>(
          create: (_) => CarrouselImageProvider(),
        ), // Adicione o CarrouselImageProvider
        // Caso futuramente adicione mais providers, basta incluí-los aqui.
      ],
      child: MaterialApp(
        title: 'Motéis App',
        theme: ThemeData(useMaterial3:true, colorSchemeSeed:  Colors.white),
        home: const MoteisScreen(),
      ),
    );
  }
}

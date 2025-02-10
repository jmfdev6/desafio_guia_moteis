import 'package:flutter/material.dart';
import 'package:guia_moteis/domain/usecases/get_moteis.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dependency_injection.dart';
import 'package:guia_moteis/presentation/providers/motel_list_provider.dart';
import 'package:guia_moteis/presentation/providers/carrousel_image_provider.dart';
import 'package:guia_moteis/presentation/screens/motel_screen.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> main() async {
  // Garante que os bindings do Flutter estejam prontos
  WidgetsFlutterBinding.ensureInitialized();
  // Inicializa o Hive para Flutter (isso configura um caminho padrão para armazenar as boxes)
  await Hive.initFlutter();
  
  // Configura as dependências (registrando serviços, repositórios, etc.)
  setupDependencies();
  
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
            getMoteisUseCase: getIt<GetMoteis>(),
          )..loadMoteis(),
        ),
        ChangeNotifierProvider<CarrouselImageProvider>(
          create: (_) => CarrouselImageProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Motéis App',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.white),
        home: const MoteisScreen(),
      ),
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:guia_moteis/presentation/providers/carrousel_image_provider.dart';
import 'data/services/moteis_api_service.dart';
import 'data/repositories/moteis_repository_impl.dart';
import 'domain/usecases/get_moteis.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Registra o serviço de API (considere externalizar a URL se necessário)
  getIt.registerSingleton<MoteisApiService>(
    MoteisApiService(baseUrl: "https://api.npoint.io/3e582bab936df79f08a5"),
  );

  // Registra o repositório que depende do serviço de API
  getIt.registerSingleton<MoteisRepositoryImpl>(
    MoteisRepositoryImpl(apiService: getIt<MoteisApiService>()),
  );

  // Registra o caso de uso que depende do repositório
  getIt.registerSingleton<GetMoteis>(
    GetMoteis(getIt<MoteisRepositoryImpl>()),
  );
  getIt.registerSingleton<CarrouselImageProvider>(
    CarrouselImageProvider(),
  );
}

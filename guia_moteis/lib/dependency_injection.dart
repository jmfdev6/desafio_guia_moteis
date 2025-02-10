import 'package:get_it/get_it.dart';
import 'package:guia_moteis/data/datasources/remote_data_source.dart';
import 'package:guia_moteis/data/services/moteis_api_service.dart';
import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/repositories/moteis_repository_impl.dart';
import 'package:guia_moteis/domain/usecases/get_moteis.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Registra o MoteisApiService
  getIt.registerLazySingleton<MoteisApiService>(
      () => MoteisApiService(baseUrl: "https://api.npoint.io/3e582bab936df79f08a5"));

  // Registra o RemoteDataSource
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(apiService: getIt<MoteisApiService>()));

  // Registra o LocalCache
  getIt.registerLazySingleton<LocalCache>(() => LocalCache());

  // Registra o MoteisRepository usando a interface
  getIt.registerLazySingleton<MoteisRepository>(
      () => MoteisRepositoryImpl(
            remoteDataSource: getIt<RemoteDataSource>(),
            localCache: getIt<LocalCache>(),
          ));

  // Registra o GetMoteis use case
  getIt.registerLazySingleton<GetMoteis>(() => GetMoteis(getIt<MoteisRepository>()));
}

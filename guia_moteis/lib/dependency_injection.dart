import 'package:get_it/get_it.dart';

import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/datasources/moteis_local_data_source.dart';
import 'package:guia_moteis/data/datasources/moteis_remote_data_source.dart';
import 'package:guia_moteis/data/repositories/moteis_repository_impl.dart';
import 'package:guia_moteis/data/services/moteis_api_service.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';
import 'package:guia_moteis/domain/usecases/get_moteis.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Cache
  getIt.registerLazySingleton(() => LocalCache.instance);
  getIt.registerLazySingleton(() => Connectivity());

  // Data Sources
  getIt.registerLazySingleton(() => MoteisApiService(baseUrl:  "https://api.npoint.io/3e582bab936df79f08a5")); // Registra o serviço primeiro
  getIt.registerLazySingleton(() => MoteisRemoteDataSource(
        apiService: getIt<MoteisApiService>(),
      ));
  getIt.registerLazySingleton(() => MoteisLocalDataSource(
        localCache: getIt<LocalCache>(),
      ));

  // Repositório (CORRETO)
  getIt.registerLazySingleton<MoteisRepository>(() => MoteisRepositoryImpl(
        remoteDataSource: getIt<MoteisRemoteDataSource>(),
        localDataSource: getIt<MoteisLocalDataSource>(),
        connectivity: getIt<Connectivity>(),
      ));

  // Use Cases
  getIt.registerLazySingleton(() => GetMoteisUseCase(
        repository: getIt<MoteisRepository>(),
      ));
}
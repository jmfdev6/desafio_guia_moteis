import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/datasources/remote_data_source.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:guia_moteis/domain/entities/motel_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

class MoteisRepositoryImpl implements MoteisRepository {
  final RemoteDataSource remoteDataSource;
  final LocalCache localCache;

  MoteisRepositoryImpl({
    required this.remoteDataSource,
    required this.localCache,
  });

  @override
  Future<MoteisEntity> getMoteis() async {
    try {
      // Verifica a conectividade
      final isOnline = await _isConnected();
      if (isOnline) {
        // Se estiver online, busca os dados da API
        final response = await remoteDataSource.fetchMoteisJson();
        final model = MoteisModel.fromJson(response);
        // Atualiza o cache com os dados mais recentes
        await localCache.cacheMoteis(model);
        return model.toEntity();
      } else {
        // Se estiver offline, tenta buscar os dados do cache
        final cachedModel = await localCache.getCachedMoteis();
        if (cachedModel != null) {
          return cachedModel.toEntity();
        } else {
          throw Exception('Sem conexão e sem dados em cache');
        }
      }
    } catch (e) {
      // Em caso de erro (por exemplo, falha na API), tenta retornar os dados do cache
      final cachedModel = await localCache.getCachedMoteis();
      if (cachedModel != null) {
        return cachedModel.toEntity();
      }
      rethrow;
    }
  }

  Future<bool> _isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<void> saveMotel(MotelEntity motel) {
    // TODO: implement saveMotel
    throw UnimplementedError();
  }
}

// ignore_for_file: unrelated_type_equality_checks

import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/datasources/remote_data_source.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import the connectivity package
import 'package:guia_moteis/domain/entities/motel_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

class MoteisRepositoryImpl implements MoteisRepository {
  final RemoteDataSource remoteDataSource;
  final LocalCache localCache;
  final Connectivity connectivity; // Add the Connectivity dependency

  MoteisRepositoryImpl({
    required this.remoteDataSource,
    required this.localCache,
    required this.connectivity, // Initialize the Connectivity
  });

  @override
  Future<MoteisEntity> getMoteis() async {
    try {
      // Use the injected Connectivity instance
      final isOnline = await _isConnected();
      if (isOnline) {
        final response = await remoteDataSource.fetchMoteisJson();
        final model = MoteisModel.fromJson(response);
        await localCache.cacheMoteis(model);
        return model.toEntity();
      } else {
        final cachedModel = await localCache.getCachedMoteis();
        if (cachedModel != null) {
          return cachedModel.toEntity();
        } else {
          throw Exception('Sem conexão e sem dados em cache');
        }
      }
    } catch (e) {
      final cachedModel = await localCache.getCachedMoteis();
      if (cachedModel != null) {
        return cachedModel.toEntity();
      }
      rethrow;
    }
  }

  Future<bool> _isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Future<void> saveMotel(MotelEntity motel) {
    throw UnimplementedError();
  }
}
// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:guia_moteis/data/datasources/moteis_remote_data_source.dart';
import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:guia_moteis/domain/entities/motel_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

class MoteisRepositoryImpl implements MoteisRepository {
  final MoteisRemoteDataSource remoteDataSource;
  final LocalCache localCache;
  final Connectivity connectivity;

  MoteisRepositoryImpl({
    required this.remoteDataSource,
    required this.localCache,
    required this.connectivity,
  });

  @override
  Future<MoteisEntity> getMoteis() async {
    final isConnected = await _isConnected();

    if (isConnected) {
      final json = await remoteDataSource.fetchMoteisJson();
      final model = MoteisModel.fromJson(json);
      await localCache.cacheMoteis(model);
      return model.toEntity();
    } else {
      final cachedModel = await localCache.getCachedMoteis();
      if (cachedModel != null) {
        return cachedModel.toEntity();
      } else {
        throw Exception('Sem conexão e sem cache disponível');
      }
    }
  }

  Future<bool> _isConnected() async {
    final result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  @override
  Future<void> saveMotel(MotelEntity motel) {
    throw UnimplementedError();
  }
}
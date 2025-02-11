import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:guia_moteis/data/datasources/moteis_local_data_source.dart';
import 'package:guia_moteis/data/datasources/moteis_remote_data_source.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:guia_moteis/domain/entities/motel_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

class MoteisRepositoryImpl implements MoteisRepository {
  final MoteisRemoteDataSource remoteDataSource;
  final MoteisLocalDataSource localDataSource;
  final Connectivity connectivity;

  MoteisRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.connectivity,
  });

  @override
  Future<MoteisEntity> getMoteis() async {
    final isOnline = await _isConnected();

    try {
      if (isOnline) {
        final moteisJson = await remoteDataSource.fetchMoteisJson();
        final moteis = MoteisModel.fromJson(moteisJson);
        await localDataSource.cacheMoteis(moteis);
        return moteis.toEntity();
      } else {
        final cachedMoteis = await localDataSource.getCachedMoteis();
        if (cachedMoteis != null) {
          return cachedMoteis.toEntity();
        } else {
          throw NoConnectionException('Sem conexão e sem dados em cache.');
        }
      }
    } catch (e) {
      if (e is NoConnectionException) rethrow; // Re-lança a exceção de conexão
      final cachedMoteis = await localDataSource.getCachedMoteis();
      if (cachedMoteis != null) {
        return cachedMoteis.toEntity();
      }
      throw RepositoryException('Erro ao obter dados: $e');
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

class NoConnectionException implements Exception {
  final String message;
  NoConnectionException(this.message);

  @override
  String toString() => 'NoConnectionException: $message';
}

class RepositoryException implements Exception {
  final String message;
  RepositoryException(this.message);

  @override
  String toString() => 'RepositoryException: $message';
}
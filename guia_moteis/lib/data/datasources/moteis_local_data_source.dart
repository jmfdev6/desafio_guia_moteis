import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';

class MoteisLocalDataSource {
  final LocalCache localCache;

  MoteisLocalDataSource({required this.localCache});

  Future<MoteisModel?> getCachedMoteis() async {
    try {
      return await localCache.getCachedMoteis();
    } catch (e) {
      throw CacheException('Falha ao ler dados do cache: $e');
    }
  }

  Future<void> cacheMoteis(MoteisModel moteis) async {
    try {
      await localCache.cacheMoteis(moteis);
    } catch (e) {
      throw CacheException('Falha ao salvar dados no cache: $e');
    }
  }
}

class CacheException implements Exception {
  final String message;
  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}
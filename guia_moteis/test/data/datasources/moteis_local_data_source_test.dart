import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/models/data_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:guia_moteis/data/datasources/moteis_local_data_source.dart';

import 'package:guia_moteis/data/models/moteis_model.dart';

import 'moteis_local_data_source_test.mocks.dart';

@GenerateMocks([LocalCache])
void main() {
  late MoteisLocalDataSource dataSource;
  late MockLocalCache mockLocalCache;

  setUp(() {
    mockLocalCache = MockLocalCache();
    dataSource = MoteisLocalDataSource(localCache: mockLocalCache);
  });

  group('MoteisLocalDataSource', () {
    test('Deve retornar um objeto MoteisModel ao obter dados do cache com sucesso',
        () async {
      final mockMoteis = MoteisModel(data: DataModel(moteis: []));
      when(mockLocalCache.getCachedMoteis()).thenAnswer((_) async => mockMoteis);

      final result = await dataSource.getCachedMoteis();

      expect(result, mockMoteis);
      verify(mockLocalCache.getCachedMoteis()).called(1);
    });

    test('Deve retornar null se não houver dados no cache', () async {
      when(mockLocalCache.getCachedMoteis()).thenAnswer((_) async => null);

      final result = await dataSource.getCachedMoteis();

      expect(result, null);
      verify(mockLocalCache.getCachedMoteis()).called(1);
    });

    test('Deve lançar uma exceção CacheException ao ocorrer um erro no cache',
        () async {
      when(mockLocalCache.getCachedMoteis())
          .thenThrow(Exception('Erro no cache'));

      expect(() async => await dataSource.getCachedMoteis(),
          throwsA(isA<CacheException>()));
      verify(mockLocalCache.getCachedMoteis()).called(1);
    });
  });
}
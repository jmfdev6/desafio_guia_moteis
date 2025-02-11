import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/data/datasources/remote_data_source.dart';
import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/data/repositories/moteis_repository_impl.dart';
import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Import Connectivity
import 'moteis_repository_impl_test.mocks.dart';

@GenerateMocks([RemoteDataSource, LocalCache, Connectivity]) // Mock Connectivity
void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalCache mockLocalCache;
  late MockConnectivity mockConnectivity; // Mock Connectivity
  late MoteisRepository repository;

  // JSON de teste
  final Map<String, dynamic> testJson = { /* ... seu JSON de teste ... */ };

  late MoteisModel testModel;
  late MoteisEntity testEntity;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalCache = MockLocalCache();
    mockConnectivity = MockConnectivity(); // Initialize Connectivity Mock
    repository = MoteisRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localCache: mockLocalCache,
      connectivity: mockConnectivity, // Inject Connectivity Mock
    );
    testModel = MoteisModel.fromJson(testJson); // Adicione a exclamação (!)
    testEntity = testModel.toEntity();
  });

  group('MoteisRepositoryImpl', () {
    test('Deve retornar dados da API e atualizar o cache quando online', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]); // Stub Connectivity
      when(mockRemoteDataSource.fetchMoteisJson()).thenAnswer((_) async => testJson);
      when(mockLocalCache.cacheMoteis(any)).thenAnswer((_) async => Future.value());

      final result = await repository.getMoteis();

      expect(result, testEntity);
      verify(mockRemoteDataSource.fetchMoteisJson()).called(1);
      verify(mockLocalCache.cacheMoteis(testModel)).called(1);
    });

    test('Deve retornar dados do cache quando ocorrer erro na API e houver cache', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.wifi]); // Stub Connectivity
      when(mockRemoteDataSource.fetchMoteisJson()).thenThrow(Exception('Offline'));
      when(mockLocalCache.getCachedMoteis()).thenAnswer((_) async => testModel);

      final result = await repository.getMoteis();

      expect(result, testEntity);
      verify(mockRemoteDataSource.fetchMoteisJson()).called(1);
      verify(mockLocalCache.getCachedMoteis()).called(1); // Corrected verification
    });

    test('Deve lançar exceção quando estiver offline e não houver cache', () async {
      when(mockConnectivity.checkConnectivity()).thenAnswer((_) async => [ConnectivityResult.none]); // Stub Connectivity
      when(mockRemoteDataSource.fetchMoteisJson()).thenThrow(Exception('Offline'));
      when(mockLocalCache.getCachedMoteis()).thenAnswer((_) async => null);

      expect(() async => await repository.getMoteis(), throwsException);
      verify(mockRemoteDataSource.fetchMoteisJson()).called(1);
      verify(mockLocalCache.getCachedMoteis()).called(1); // Corrected verification
    });
  });
}
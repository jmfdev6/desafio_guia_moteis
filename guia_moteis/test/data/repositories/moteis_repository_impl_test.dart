import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:guia_moteis/data/datasources/moteis_local_data_source.dart';
import 'package:guia_moteis/data/datasources/moteis_remote_data_source.dart';
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/data/repositories/moteis_repository_impl.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'moteis_repository_impl_test.mocks.dart';

@GenerateMocks([MoteisRemoteDataSource, MoteisLocalDataSource, Connectivity])
void main() {
  late MoteisRepositoryImpl repository;
  late MockMoteisRemoteDataSource mockRemoteDataSource;
  late MockMoteisLocalDataSource mockLocalDataSource;
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockRemoteDataSource = MockMoteisRemoteDataSource();
    mockLocalDataSource = MockMoteisLocalDataSource();
    mockConnectivity = MockConnectivity();
    repository = MoteisRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      connectivity: mockConnectivity,
    );
  });

  group('MoteisRepositoryImpl', () {
    test('Deve retornar dados da API e atualizar o cache quando online', () async {
      final mockJson = {
        "moteis": [
          {
            "id": 1,
            "name": "Motel Exemplo",
            "address": "Rua Exemplo, 123",
            "phone": "(12) 3456-7890",
            "images": ["url_da_imagem_1", "url_da_imagem_2"]
          }
        ]
      };
      final mockMoteis = MoteisModel.fromJson(mockJson);
      final mockEntity = mockMoteis.toEntity();

      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.wifi]);
      when(mockRemoteDataSource.fetchMoteisJson()).thenAnswer((_) async => mockJson);
      when(mockLocalDataSource.cacheMoteis(any)).thenAnswer((_) async => Future.value());

      final result = await repository.getMoteis();

      expect(result, mockEntity);
      verify(mockRemoteDataSource.fetchMoteisJson()).called(1);
      verify(mockLocalDataSource.cacheMoteis(mockMoteis)).called(1);
    });

    test('Deve retornar dados do cache quando offline', () async {
      final mockJson = {
        "moteis": [
          {
            "id": 1,
            "name": "Motel Exemplo",
            "address": "Rua Exemplo, 123",
            "phone": "(12) 3456-7890",
            "images": ["url_da_imagem_1", "url_da_imagem_2"]
          }
        ]
      };
      final mockMoteis = MoteisModel.fromJson(mockJson);
      final mockEntity = mockMoteis.toEntity();

      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      when(mockLocalDataSource.getCachedMoteis())
          .thenAnswer((_) async => Future.value(mockMoteis));

      final result = await repository.getMoteis();

      expect(result, mockEntity);
      verifyNever(mockRemoteDataSource.fetchMoteisJson());
      verify(mockLocalDataSource.getCachedMoteis()).called(1);
    });

    test('Deve lançar uma exceção quando offline e não houver cache', () async {
      when(mockConnectivity.checkConnectivity())
          .thenAnswer((_) async => [ConnectivityResult.none]);
      when(mockLocalDataSource.getCachedMoteis()).thenAnswer((_) async => null);

      expect(() async => await repository.getMoteis(), throwsException);
      verifyNever(mockRemoteDataSource.fetchMoteisJson());
      verify(mockLocalDataSource.getCachedMoteis()).called(1);
    });

    // Testes para cenários de erro na API e no cache
    // ...
  });
}
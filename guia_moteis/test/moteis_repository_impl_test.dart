import 'package:flutter_test/flutter_test.dart';

import 'package:guia_moteis/data/datasources/local_cache.dart';
import 'package:guia_moteis/data/datasources/remote_data_source.dart' show RemoteDataSource;
import 'package:guia_moteis/data/models/moteis_model.dart';
import 'package:guia_moteis/data/repositories/moteis_repository_impl.dart';
import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// Mocks
class MockRemoteDataSource extends Mock implements RemoteDataSource {}
class MockLocalCache extends Mock implements LocalCache {}
class MockConnectivity extends Mock implements Connectivity {}
class FakeMoteisModel extends Fake implements MoteisModel {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized(); // Inicializa o binding

  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalCache mockLocalCache;
  late MockConnectivity mockConnectivity;
  late MoteisRepositoryImpl repository;

  final Map<String, dynamic> testJson = {
    "sucesso": true,
    "data": {
      "pagina": 1,
      "qtdPorPagina": 10,
      "totalSuites": 0,
      "totalMoteis": 1,
      "raio": 0,
      "maxPaginas": 1.0,
      "moteis": [
        {
          "fantasia": "Motel Le Nid",
          "logo": "https://cdn.guiademoteis.com.br/imagens/logotipos/3148-le-nid.gif",
          "bairro": "Chácara Flora - São Paulo",
          "distancia": 28.27,
          "qtdFavoritos": 0,
          "qtdAvaliacoes": 2159,
          "media": 4.6,
          "suites": [
            {
              "nome": "Suíte Marselha s/ garagem privativa",
              "qtd": 1,
              "exibirQtdDisponiveis": true,
              "fotos": [
                "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_1.jpg",
                "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_2.jpg",
                "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_3.jpg",
                "https://cdn.guiademoteis.com.br/imagens/suites/big/3148_big_9827_4.jpg"
              ],
              "itens": [
                {"nome": "ducha dupla"},
                {"nome": "TV a cabo"}
              ],
              "categoriaItens": [
                {"nome": "Frigobar", "icone": "https://cdn.guiademoteis.com.br/Images/itens-suites/frigobar-04-09-2018-12-14.png"}
              ],
              "periodos": [
                {
                  "tempoFormatado": "3 horas",
                  "tempo": "3",
                  "valor": 88.0,
                  "valorTotal": 88.0,
                  "temCortesia": false,
                  "desconto": null
                }
              ]
            }
          ]
        }
      ]
    }
  };
  late MoteisModel testModel;
  late MoteisEntity testEntity;

  setUpAll(() {
    registerFallbackValue(FakeMoteisModel());
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalCache = MockLocalCache();
    mockConnectivity = MockConnectivity();
    repository = MoteisRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localCache: mockLocalCache,
    );

    testModel = MoteisModel.fromJson(testJson);
    testEntity = testModel.toEntity();
    when(() => mockLocalCache.getCachedMoteis()).thenAnswer((_) async => null);
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.wifi]);
  });

  test('Deve retornar dados da API e atualizar o cache quando online', () async {
    when(() => mockRemoteDataSource.fetchMoteisJson()).thenAnswer((_) async => testJson);
    when(() => mockLocalCache.cacheMoteis(any())).thenAnswer((_) async {});

    final result = await repository.getMoteis();

    expect(result, testEntity);
    verify(() => mockRemoteDataSource.fetchMoteisJson()).called(1);
    verify(() => mockLocalCache.cacheMoteis(testModel)).called(1);
  });

  test('Deve retornar dados do cache quando offline com cache', () async {
    when(() => mockRemoteDataSource.fetchMoteisJson()).thenThrow(Exception());
    when(() => mockLocalCache.getCachedMoteis()).thenAnswer((_) async => testModel);
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    final result = await repository.getMoteis();

    expect(result, testEntity);
    verify(() => mockRemoteDataSource.fetchMoteisJson()).called(1);
    verify(() => mockLocalCache.getCachedMoteis()).called(1);
  });

  test('Deve lançar exceção quando offline sem cache', () async {
    when(() => mockRemoteDataSource.fetchMoteisJson()).thenThrow(Exception());
    when(() => mockLocalCache.getCachedMoteis()).thenAnswer((_) async => null);
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none ]);

    expect(() => repository.getMoteis(), throwsA(isA<Exception>()));
    verify(() => mockRemoteDataSource.fetchMoteisJson()).called(1);
    verify(() => mockLocalCache.getCachedMoteis()).called(1);
  });
}
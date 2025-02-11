import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:guia_moteis/data/datasources/moteis_remote_data_source.dart';
import 'package:guia_moteis/data/services/moteis_api_service.dart';

import 'moteis_remote_data_source_test.mocks.dart';

@GenerateMocks([MoteisApiService])
void main() {
  late MoteisRemoteDataSource dataSource;
  late MockMoteisApiService mockApiService;

  setUp(() {
    mockApiService = MockMoteisApiService();
    dataSource = MoteisRemoteDataSource(apiService: mockApiService);
  });

  group('MoteisRemoteDataSource', () {
    test('Deve retornar um mapa JSON ao obter dados da API com sucesso', () async {
      final mockJson = {'data': {}};
      when(mockApiService.fetchMoteis()).thenAnswer((_) async => mockJson);

      final result = await dataSource.fetchMoteisJson();

      expect(result, mockJson);
      verify(mockApiService.fetchMoteis()).called(1);
    });

    test('Deve lançar uma exceção ApiException ao ocorrer um erro na API', () async {
      when(mockApiService.fetchMoteis()).thenThrow(Exception('Erro na API'));

      expect(() async => await dataSource.fetchMoteisJson(),
          throwsA(isA<ApiException>()));
      verify(mockApiService.fetchMoteis()).called(1);
    });
  });
}
import 'package:guia_moteis/data/services/moteis_api_service.dart'; // Importe o serviço da API

class MoteisRemoteDataSource {
  final MoteisApiService apiService;

  MoteisRemoteDataSource({required this.apiService});

  Future<Map<String, dynamic>> fetchMoteisJson() async {
    try {
      final response = await apiService.fetchMoteis();
      return response;
    } catch (e) {
      throw ApiException('Falha ao buscar dados da API: ');
    }
  }
}

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => 'Sem conexão ';
}
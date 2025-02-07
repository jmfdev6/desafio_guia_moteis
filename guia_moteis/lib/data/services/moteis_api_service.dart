import 'dart:convert';
import 'package:http/http.dart' as http;

class MoteisApiService {
  final String baseUrl;

  MoteisApiService({required this.baseUrl});

  /// Realiza a requisição para buscar os motéis e retorna o JSON
  Future<Map<String, dynamic>> fetchMoteis() async {
    final response = await http.get(Uri.parse('$baseUrl/moteis'));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Erro ao buscar motéis');
    }
  }
}

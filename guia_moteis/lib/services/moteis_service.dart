import 'package:dio/dio.dart';
import 'package:guia_moteis/models/moteis_model.dart';

class MoteisService {
  static const String apiUrl = "https://api.npoint.io/3e582bab936df79f08a5";
  final Dio dio = Dio();

  Future<MoteisModel?> fetchMoteis() async {
    try {
      print("🔍 Iniciando requisição para $apiUrl");
      final response = await dio.get(apiUrl);
      
      print("✅ Resposta recebida (Código: ${response.statusCode})");
      print("📝 Dados recebidos: ${response.data}");

      if (response.statusCode == 200) {
        return MoteisModel.fromJson(response.data);
      } else {
        print("❌ Erro na resposta: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("🚨 Erro na requisição: $e");
      return null;
    }
  }
}

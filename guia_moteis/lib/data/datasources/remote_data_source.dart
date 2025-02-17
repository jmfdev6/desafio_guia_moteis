import 'package:guia_moteis/data/services/moteis_api_service.dart';
class RemoteDataSource {
  final MoteisApiService apiService;
  RemoteDataSource({required this.apiService});
  Future<Map<String, dynamic>> fetchMoteisJson() async {
    return await apiService.fetchMoteis();
  }
}
import 'package:guia_moteis/domain/entities/motel_entity.dart';

import '../../domain/entities/moteis_entity.dart';
import '../../domain/repositories/moteis_repository.dart';
import '../services/moteis_api_service.dart';
import '../models/moteis_model.dart';

class MoteisRepositoryImpl implements MoteisRepository {
  final MoteisApiService apiService;

  MoteisRepositoryImpl({required this.apiService});

  @override
  Future<MoteisEntity> getMoteis() async {
    final jsonData = await apiService.fetchMoteis();
    final model = MoteisModel.fromJson(jsonData);
    return model.toEntity();
  }

  @override
  Future<void> saveMotel(MotelEntity motel) async {
    // Implemente a lógica para salvar um Motel, convertendo-o para um modelo e enviando para a API, por exemplo.
  }
}

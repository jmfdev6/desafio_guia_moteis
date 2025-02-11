import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

class GetMoteisUseCase {
  final MoteisRepository repository;

  GetMoteisUseCase({required this.repository});

  Future<MoteisEntity> execute() async {
    return await repository.getMoteis();
  }
}
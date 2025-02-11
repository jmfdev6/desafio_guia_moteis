import 'package:guia_moteis/domain/entities/moteis_entity.dart';
import 'package:guia_moteis/domain/repositories/moteis_repository.dart';

class GetMoteis {
  final MoteisRepository repository;

  GetMoteis(this.repository);

  Future<MoteisEntity> call() async {
    return await repository.getMoteis();
  }
}

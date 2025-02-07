import '../entities/moteis_entity.dart';
import '../repositories/moteis_repository.dart';

class GetMoteis {
  final MoteisRepository repository;

  GetMoteis(this.repository);

  Future<MoteisEntity> call() async {
    return await repository.getMoteis();
  }
}

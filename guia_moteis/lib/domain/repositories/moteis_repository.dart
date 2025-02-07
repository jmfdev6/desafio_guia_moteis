import 'package:guia_moteis/domain/entities/motel_entity.dart';

import '../entities/moteis_entity.dart';

abstract class MoteisRepository {
  Future<MoteisEntity> getMoteis();
  Future<void> saveMotel(MotelEntity motel);
  // Outros métodos conforme a necessidade...
}

// domain/entities/data_entity.dart
import 'motel_entity.dart';

class DataEntity {
  final int pagina;
  final int qtdPorPagina;
  final int totalSuites;
  final int totalMoteis;
  final int raio;
  final int maxPaginas;
  final List<MotelEntity> moteis;

  DataEntity({
    required this.pagina,
    required this.qtdPorPagina,
    required this.totalSuites,
    required this.totalMoteis,
    required this.raio,
    required this.maxPaginas,
    required this.moteis,
  });
}

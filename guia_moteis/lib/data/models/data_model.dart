// data/models/data_model.dart
import '../../domain/entities/data_entity.dart';
import 'motel_model.dart';

class DataModel {
  int? pagina;
  int? qtdPorPagina;
  int? totalSuites;
  int? totalMoteis;
  int? raio;
  int? maxPaginas;
  List<MotelModel>? moteis;

  DataModel({
    this.pagina,
    this.qtdPorPagina,
    this.totalSuites,
    this.totalMoteis,
    this.raio,
    this.maxPaginas,
    this.moteis,
  });

  DataModel.fromJson(Map<String, dynamic> json) {
    pagina = (json['pagina'] as num?)?.toInt();
    qtdPorPagina = (json['qtdPorPagina'] as num?)?.toInt();
    totalSuites = (json['totalSuites'] as num?)?.toInt();
    totalMoteis = (json['totalMoteis'] as num?)?.toInt();
    raio = (json['raio'] as num?)?.toInt();
    maxPaginas = (json['maxPaginas'] as num?)?.toInt();
    if (json['moteis'] != null) {
      moteis = (json['moteis'] as List)
          .map((e) => MotelModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'pagina': pagina,
      'qtdPorPagina': qtdPorPagina,
      'totalSuites': totalSuites,
      'totalMoteis': totalMoteis,
      'raio': raio,
      'maxPaginas': maxPaginas,
      'moteis': moteis?.map((e) => e.toJson()).toList(),
    };
  }

  // Converte para a entidade de domínio
  DataEntity toEntity() {
    return DataEntity(
      pagina: pagina ?? 0,
      qtdPorPagina: qtdPorPagina ?? 0,
      totalSuites: totalSuites ?? 0,
      totalMoteis: totalMoteis ?? 0,
      raio: raio ?? 0,
      maxPaginas: maxPaginas ?? 0,
      moteis: moteis?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

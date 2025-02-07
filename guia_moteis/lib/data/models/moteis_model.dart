// data/models/moteis_model.dart
import 'package:guia_moteis/domain/entities/data_entity.dart';

import '../../domain/entities/moteis_entity.dart';
import 'data_model.dart';

class MoteisModel {
  bool? sucesso;
  DataModel? data;

  MoteisModel({this.sucesso, this.data});

  MoteisModel.fromJson(Map<String, dynamic> json) {
    sucesso = json['sucesso'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    return {
      'sucesso': sucesso,
      'data': data?.toJson(),
    };
  }

  // Converte para a entidade de domínio
  MoteisEntity toEntity() {
    return MoteisEntity(
      sucesso: sucesso ?? false,
      data: data?.toEntity() ??
          // caso data seja nulo, você pode definir um valor padrão ou lançar uma exceção
          DataEntity(
            pagina: 0,
            qtdPorPagina: 0,
            totalSuites: 0,
            totalMoteis: 0,
            raio: 0,
            maxPaginas: 0,
            moteis: [],
          ),
    );
  }
}

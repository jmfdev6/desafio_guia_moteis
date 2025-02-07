// data/models/motel_model.dart
import '../../domain/entities/motel_entity.dart';
import 'suite_model.dart';

class MotelModel {
  String? fantasia;
  String? logo;
  String? bairro;
  double? distancia;
  int? qtdFavoritos;
  int? qtdAvaliacoes;
  double? media;
  List<SuiteModel>? suites;

  MotelModel({
    this.fantasia,
    this.logo,
    this.bairro,
    this.distancia,
    this.qtdFavoritos,
    this.qtdAvaliacoes,
    this.media,
    this.suites,
  });

  MotelModel.fromJson(Map<String, dynamic> json) {
    fantasia = json['fantasia'];
    logo = json['logo'];
    bairro = json['bairro'];
    distancia = (json['distancia'] as num?)?.toDouble();
    qtdFavoritos = (json['qtdFavoritos'] as num?)?.toInt();
    qtdAvaliacoes = (json['qtdAvaliacoes'] as num?)?.toInt();
    media = (json['media'] as num?)?.toDouble();
    if (json['suites'] != null) {
      suites = (json['suites'] as List)
          .map((e) => SuiteModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'fantasia': fantasia,
      'logo': logo,
      'bairro': bairro,
      'distancia': distancia,
      'qtdFavoritos': qtdFavoritos,
      'qtdAvaliacoes': qtdAvaliacoes,
      'media': media,
      'suites': suites?.map((e) => e.toJson()).toList(),
    };
  }

  // Converte para a entidade de domínio
  MotelEntity toEntity() {
    return MotelEntity(
      fantasia: fantasia ?? '',
      logo: logo ?? '',
      bairro: bairro ?? '',
      distancia: distancia ?? 0.0,
      qtdFavoritos: qtdFavoritos ?? 0,
      qtdAvaliacoes: qtdAvaliacoes ?? 0,
      media: media ?? 0.0,
      suites: suites?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

// data/models/suite_model.dart
import '../../domain/entities/suite_entity.dart';
import 'itens_model.dart';
import 'categoria_itens_model.dart';
import 'periodos_model.dart';

class SuiteModel {
  String? nome;
  int? qtd;
  bool? exibirQtdDisponiveis;
  List<String>? fotos;
  List<ItensModel>? itens;
  List<CategoriaItensModel>? categoriaItens;
  List<PeriodosModel>? periodos;

  SuiteModel({
    this.nome,
    this.qtd,
    this.exibirQtdDisponiveis,
    this.fotos,
    this.itens,
    this.categoriaItens,
    this.periodos,
  });

  SuiteModel.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    qtd = (json['qtd'] as num?)?.toInt();
    exibirQtdDisponiveis = json['exibirQtdDisponiveis'];
    fotos = json['fotos'] != null ? List<String>.from(json['fotos']) : [];
    if (json['itens'] != null) {
      itens = (json['itens'] as List)
          .map((e) => ItensModel.fromJson(e))
          .toList();
    }
    if (json['categoriaItens'] != null) {
      categoriaItens = (json['categoriaItens'] as List)
          .map((e) => CategoriaItensModel.fromJson(e))
          .toList();
    }
    if (json['periodos'] != null) {
      periodos = (json['periodos'] as List)
          .map((e) => PeriodosModel.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'qtd': qtd,
      'exibirQtdDisponiveis': exibirQtdDisponiveis,
      'fotos': fotos,
      'itens': itens?.map((e) => e.toJson()).toList(),
      'categoriaItens': categoriaItens?.map((e) => e.toJson()).toList(),
      'periodos': periodos?.map((e) => e.toJson()).toList(),
    };
  }

  // Converte para a entidade de domínio
  SuiteEntity toEntity() {
    return SuiteEntity(
      nome: nome ?? '',
      qtd: qtd ?? 0,
      exibirQtdDisponiveis: exibirQtdDisponiveis ?? false,
      fotos: fotos ?? [],
      itens: itens?.map((e) => e.toEntity()).toList() ?? [],
      categoriaItens:
          categoriaItens?.map((e) => e.toEntity()).toList() ?? [],
      periodos: periodos?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}

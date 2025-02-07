// lib/domain/entities/suite_entity.dart
import 'itens_entity.dart';
import 'categoria_itens_entity.dart';
import 'periodos_entity.dart';

class SuiteEntity {
  final String nome;
  final int qtd;
  final bool exibirQtdDisponiveis;
  final List<String> fotos;
  final List<ItensEntity> itens;
  final List<CategoriaItensEntity> categoriaItens;
  final List<PeriodosEntity> periodos;

  SuiteEntity({
    required this.nome,
    required this.qtd,
    required this.exibirQtdDisponiveis,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });
}

import '../../domain/entities/categoria_itens_entity.dart';

class CategoriaItensModel {
  final String nome;
  final String icone;

  CategoriaItensModel({required this.nome, required this.icone});

  factory CategoriaItensModel.fromJson(Map<String, dynamic> json) {
    return CategoriaItensModel(
      nome: json['nome'] as String,
      icone: json['icone'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'icone': icone,
    };
  }

  CategoriaItensEntity toEntity() {
    return CategoriaItensEntity(
      nome: nome,
      icone: icone,
    );
  }
}

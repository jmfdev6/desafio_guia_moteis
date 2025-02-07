import '../../domain/entities/itens_entity.dart';

class ItensModel {
  final String nome;

  ItensModel({required this.nome});

  // Factory constructor para criar uma instância a partir de JSON
  factory ItensModel.fromJson(Map<String, dynamic> json) {
    return ItensModel(
      nome: json['nome'] as String,
    );
  }

  // Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
    };
  }

  // Converte o modelo para a entidade do domínio
  ItensEntity toEntity() {
    return ItensEntity(nome: nome);
  }
}

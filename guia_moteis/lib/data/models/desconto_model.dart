import '../../domain/entities/desconto_entity.dart';

class DescontoModel {
  final double desconto;

  DescontoModel({required this.desconto});

  factory DescontoModel.fromJson(Map<String, dynamic> json) {
    return DescontoModel(
      desconto: (json['desconto'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'desconto': desconto,
    };
  }

  DescontoEntity toEntity() {
    return DescontoEntity(desconto: desconto);
  }
}

import '../../domain/entities/periodos_entity.dart';
import 'desconto_model.dart'; // Se você estiver utilizando um modelo para desconto

class PeriodosModel {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final DescontoModel? desconto;

  PeriodosModel({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });

  factory PeriodosModel.fromJson(Map<String, dynamic> json) {
    return PeriodosModel(
      tempoFormatado: json['tempoFormatado'] as String,
      tempo: json['tempo']?.toString() ?? '',
      valor: (json['valor'] as num).toDouble(),
      valorTotal: (json['valorTotal'] as num).toDouble(),
      temCortesia: json['temCortesia'] as bool,
      desconto: json['desconto'] != null ? DescontoModel.fromJson(json['desconto']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tempoFormatado': tempoFormatado,
      'tempo': tempo,
      'valor': valor,
      'valorTotal': valorTotal,
      'temCortesia': temCortesia,
      'desconto': desconto?.toJson(),
    };
  }

  // Converte o modelo para a entidade do domínio
  PeriodosEntity toEntity() {
    return PeriodosEntity(
      tempoFormatado: tempoFormatado,
      tempo: tempo,
      valor: valor,
      valorTotal: valorTotal,
      temCortesia: temCortesia,
      desconto: desconto?.toEntity(), // Certifique-se de definir o método toEntity em DescontoModel
    );
  }
}

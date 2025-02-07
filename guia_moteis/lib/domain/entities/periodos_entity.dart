// lib/domain/entities/periodos_entity.dart
import 'desconto_entity.dart'; // Se você também tiver um DescontoEntity

class PeriodosEntity {
  final String tempoFormatado;
  final String tempo;
  final double valor;
  final double valorTotal;
  final bool temCortesia;
  final DescontoEntity? desconto;

  PeriodosEntity({
    required this.tempoFormatado,
    required this.tempo,
    required this.valor,
    required this.valorTotal,
    required this.temCortesia,
    this.desconto,
  });
}

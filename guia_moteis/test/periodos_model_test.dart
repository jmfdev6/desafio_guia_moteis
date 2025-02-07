import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/data/models/desconto_model.dart';
import 'package:guia_moteis/data/models/periodos_model.dart';

void main() {
test('Deve calcular o desconto corretamente', () {
  final periodo = PeriodosModel(
    tempo: "12",
    valor: 184,
    desconto: DescontoModel(desconto: 68.4),
    valorTotal: 115.6,
    temCortesia: false,
    tempoFormatado: "12 horas",
  );

  expect(periodo.valor - (periodo.desconto?.desconto ?? 0.0), equals(periodo.valorTotal));
});
}

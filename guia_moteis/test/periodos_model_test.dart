import 'package:flutter_test/flutter_test.dart';
import 'package:guia_moteis/models/moteis_model.dart';

void main() {
test('Deve calcular o desconto corretamente', () {
  final periodo = Periodos(
    tempo: "12",
    valor: 184,
    desconto: Desconto(desconto: 68.4),
    valorTotal: 115.6,
    temCortesia: false,
    tempoFormatado: "12 horas",
  );

  expect(periodo.valor! - (periodo.desconto?.desconto ?? 0.0), equals(periodo.valorTotal));
});
}

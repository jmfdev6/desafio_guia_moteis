import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/models/moteis_model.dart';

class CardSuit extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final List<CategoriaItens> categoriaItens;
  final List<Itens> description;
  final List<Periodos> price;
  final int rating;
  final int reviewCount;

  const CardSuit({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.reviewCount,
    required this.categoriaItens,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.black12.withOpacity(0.4),
      backgroundColor: Colors.black12.withOpacity(0.5),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w900,
        ),
      ),
      subtitle: Text("Mais informações"),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícones das categorias
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: categoriaItens.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              CachedNetworkImageProvider(item.icone!),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                // Itens da categoria
                ExpansionTile(
                  title: const Text("Itens"),
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: description.map((item) {
                        return Chip(
                          label: Text(item.nome ?? ''),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Tabela de preços
                Table(
                  border: TableBorder.all(width: 0.5, color: Colors.deepPurple),
                  columnWidths: const {
                    0: FlexColumnWidth(3), // Tempo
                    1: FlexColumnWidth(2), // Valor
                    2: FlexColumnWidth(2), // Desconto
                    3: FlexColumnWidth(2), // Total
                  },
                  children: [
                    // Cabeçalho da tabela
                    const TableRow(
                      decoration: BoxDecoration(color: Colors.deepPurple),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Tempo",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Valor",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Desconto",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Total",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    // Dados da tabela
                    ...price.map((item) => TableRow(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.tempoFormatado!,
                                  textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("R\$ ${item.valor}",
                                  textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                item.desconto != null
                                    ? "R\$ ${item.desconto!.desconto}"
                                    : "-",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("R\$ ${item.valorTotal}",
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        )),
                  ],
                ),

                const SizedBox(height: 8),
                // Avaliações
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '($reviewCount avaliações)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Botão de reserva
                FilledButton(
                  onPressed: () {},
                  child: const Text("Reservar"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

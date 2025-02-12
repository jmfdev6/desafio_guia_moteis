import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/domain/entities/categoria_itens_entity.dart';
import 'package:guia_moteis/domain/entities/itens_entity.dart';
import 'package:guia_moteis/domain/entities/periodos_entity.dart';

class CardSuit extends StatelessWidget {
  final List<String> imageUrls;
  final String title;
  final List<CategoriaItensEntity> categoriaItens;
  final List<ItensEntity> description;
  final List<PeriodosEntity> price;

  const CardSuit({
    super.key,
    required this.imageUrls,
    required this.title,
    required this.description,
    required this.price,
    required this.categoriaItens,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: categoriaItens.map((item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Chip(
                        label: Text(item.nome),
                        avatar: ImageIcon(
                          CachedNetworkImageProvider(item.icone),
                          size: 40,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog.fullscreen(
                            insetAnimationCurve: Curves.bounceOut,
                            child: Column(
                              spacing: 12,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppBar(
                                  centerTitle: true,
                                  leading: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  title: Text(
                                    'Itens',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Text("Intens principal"),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: categoriaItens.map((item) {
                                    return Chip(
                                      avatar: ImageIcon(
                                        CachedNetworkImageProvider(item.icone),
                                        size: 20,
                                      ),
                                      label: Text(item.nome),
                                    );
                                  }).toList(),
                                ),
                                Text("Outros"),
                                  Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: description.map((item) {
                                    return Chip(
                                      label: Text(item.nome),
                                    );
                                  }).toList(),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  child: Positioned(right: 8, child: Text("Ver todos")),
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Preços e periodos",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xFF555658)),
          ),

          /*Wrap(
              spacing: 8,
              runSpacing: 4,
              children: description.map((item) {
                return Chip(
                  label: Text(item.nome ?? ''),
                );
              }).toList(),
            ),*/

          const SizedBox(height: 8),
          Table(
            border: TableBorder.all(width: 0.5, color: Colors.blueGrey),
            columnWidths: const {
              0: FlexColumnWidth(2), // Tempo
              1: FlexColumnWidth(3), // Valor
              2: FlexColumnWidth(2), // Desconto
              3: FlexColumnWidth(2), // Total
            },
            children: [
              ...price.map((item) => TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(item.tempoFormatado,
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
                          style: TextStyle(color: Color(0xFF2BA77A)),
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
        ],
      ),
    );
  }
}

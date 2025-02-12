import 'package:flutter/material.dart';
import 'package:guia_moteis/presentation/providers/motel_list_provider.dart';
import 'package:guia_moteis/presentation/screens/suites_screen.dart';
import 'package:guia_moteis/presentation/widgets/motel/motel_card.dart';
import 'package:guia_moteis/presentation/widgets/motel/motel_shimmer.dart';
import 'package:provider/provider.dart';

class MoteisScreen extends StatelessWidget {
  const MoteisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Motéis")),
      body: Consumer<MoteisProvider>(
        builder: (context, provider, _) {
          return RefreshIndicator(
            onRefresh: () async {
               await provider.getMoteisUseCase.repository.getMoteis(); // Chama a função para recarregar os dados
            },
            child: provider.isLoading
                ? const MoteisScreenShimmer()
                : provider.errorMessage != null
                    ? Center(child: Text(provider.errorMessage!))
                    : provider.moteis == null
                        ? const Center(child: Text("Nenhum dado disponível."))
                        : ListView.builder(
                            itemCount: provider.moteis!.data.moteis.length,
                            itemBuilder: (context, index) {
                              final motel = provider.moteis!.data.moteis[index];

                              // Definindo imagens com fallback
                              List<String> imagens = motel.suites.isNotEmpty
                                  ? motel.suites.first.fotos
                                  : [
                                      'https://ralfvanveen.com/wp-content/uploads/2021/06/Placeholder-_-Glossary-800x450.webp'
                                    ];

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Divider(
                                    height: 14,
                                    color: Color(0xFFF0F0F0),
                                    thickness: 10,
                                  ),
                                  MotelCard(motel: motel),
                                  const SizedBox(height: 2),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height * 0.8,
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: SuitesScreen(
                                      suites: motel.suites,
                                      imageUrls: imagens,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
          );
        },
      ),
    );
  }
}

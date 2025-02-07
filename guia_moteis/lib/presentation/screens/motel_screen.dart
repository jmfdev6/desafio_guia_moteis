import 'package:flutter/material.dart';
import 'package:guia_moteis/presentation/providers/motel_list_provider.dart';
import 'package:guia_moteis/presentation/screens/suites_page.dart';
import 'package:provider/provider.dart';


class MoteisScreen extends StatelessWidget {
  const MoteisScreen({super.key});

  @override
  Widget build(BuildContext context) {
     final viewModel = Provider.of<MoteisProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Motéis")),
      body: Consumer<MoteisProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text(provider.errorMessage!));
          }
          if (provider.moteis == null) {
            return const Center(child: Text("Nenhum dado disponível."));
          }

          // Exemplo: exibindo os motéis em uma ListView
          return ListView.builder(
                  itemCount: viewModel.moteis!.data.moteis.length,
                  itemBuilder: (context, index) {
                    final motel = viewModel.moteis!.data.moteis[index];

                    // Definindo imagens com fallback (usando as fotos da primeira suíte, se disponível)
                    List<String> imagens = [];
                    if (motel.suites.isNotEmpty) {
                      imagens = motel.suites.first.fotos ;
                    } else {
                      imagens = ['https://via.placeholder.com/300x200'];
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          
                          
                          leading: !motel.logo.isNotEmpty
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(motel.logo),
                                )
                              : const Icon(Icons.hotel, size: 50),
                          title: Text(motel.fantasia),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.pin_drop_outlined),
                              const SizedBox(width: 2),
                              Text(" ${motel.bairro}"),
                            ],
                          ),
                          trailing: Text(
                            "${motel.suites.length} suítes",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10,),
                       
                        Container(
                          height: MediaQuery.of(context).size.height *
                              0.8, // ajuste essa altura conforme necessário
                          margin: const EdgeInsets.only(bottom: 8),
                          child: SuitesScreen(
                            suites: motel.suites ,
                            imageUrls: imagens,
                          ),
                        ),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}

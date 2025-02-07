import 'package:flutter/material.dart';
import 'package:guia_moteis/view/suites/suites_page.dart';
import 'package:guia_moteis/view_model/moteis_viewmodel.dart';
import 'package:provider/provider.dart';

class MoteisScreen extends StatelessWidget {
  const MoteisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MoteisViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de Motéis")),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : (viewModel.moteisModel == null ||
                  viewModel.moteisModel!.data == null ||
                  viewModel.moteisModel!.data!.moteis == null ||
                  viewModel.moteisModel!.data!.moteis!.isEmpty)
              ? const Center(child: Text("Nenhum motel encontrado"))
              : ListView.builder(
                  itemCount: viewModel.moteisModel!.data!.moteis!.length,
                  itemBuilder: (context, index) {
                    final motel = viewModel.moteisModel!.data!.moteis![index];

                    // Definindo imagens com fallback (usando as fotos da primeira suíte, se disponível)
                    List<String> imagens = [];
                    if (motel.suites != null && motel.suites!.isNotEmpty) {
                      imagens = motel.suites!.first.fotos ?? [];
                    } else {
                      imagens = ['https://via.placeholder.com/300x200'];
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: motel.logo != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(motel.logo!),
                                )
                              : const Icon(Icons.hotel, size: 50),
                          title: Text(motel.fantasia ?? "Nome não disponível"),
                          subtitle: Row(
                            children: [
                              const Icon(Icons.pin_drop_outlined),
                              const SizedBox(width: 2),
                              Text(" ${motel.bairro ?? 'Desconhecido'}"),
                            ],
                          ),
                          trailing: Text(
                            "${motel.suites?.length ?? 0} suítes",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10,),
                       
                        Container(
                          height: MediaQuery.of(context).size.height *
                              0.8, // ajuste essa altura conforme necessário
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
  }
}

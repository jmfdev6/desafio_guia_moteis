import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guia_moteis/view/suites/suites_page.dart';
import 'package:guia_moteis/view_model/moteis_viewmodel.dart';
import 'package:provider/provider.dart';

class MoteisScreen extends StatelessWidget {
  const MoteisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoteisViewModel()..loadMoteis(),
      child: Scaffold(
        appBar: AppBar(title: Text("Lista de Motéis")),
        body: Consumer<MoteisViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (viewModel.moteisModel == null ||
                viewModel.moteisModel!.data == null ||
                viewModel.moteisModel!.data!.moteis == null) {
              return Center(child: Text("Nenhum motel"));
            }

            final moteis = viewModel.moteisModel!.data!.moteis!;

            return ListView.builder(
              itemCount: moteis.length,
              itemBuilder: (context, index) {
                final motel = moteis[index];

                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: motel.logo != null
                        ? CircleAvatar(
                          radius: 30,
                          backgroundImage: CachedNetworkImageProvider(motel.logo!),
                        )
                        : Icon(Icons.hotel, size: 50),
                    title: Text(motel.fantasia ?? "Nome não disponível"),
                    subtitle: Row(
                      children: [
                        Icon(Icons.pin_drop_outlined),
                        SizedBox(width: 2),
                        Text(" ${motel.bairro ?? 'Desconhecido'}"),
                      ],
                    ),
                    trailing: Text(
                      "${motel.suites?.length ?? 0} suítes",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SuitesScreen(motel.suites ?? [], imageUrls: [],),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

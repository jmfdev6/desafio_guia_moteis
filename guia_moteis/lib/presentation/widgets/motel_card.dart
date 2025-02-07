// lib/presentation/widgets/motel_card.dart
import 'package:flutter/material.dart';
import 'package:guia_moteis/domain/entities/motel_entity.dart';


class MotelCard extends StatelessWidget {
  final MotelEntity motel;

  const MotelCard({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        leading: Image.network(
          motel.logo,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(motel.fantasia),
        subtitle: Text(motel.bairro),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:guia_moteis/domain/entities/motel_entity.dart';

class MotelCard extends StatelessWidget {
  final MotelEntity motel;

  const MotelCard({super.key, required this.motel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: motel.logo.isNotEmpty
          ? CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(motel.logo),
            )
          : const Icon(Icons.hotel, size: 50),
      title: Text(motel.fantasia),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " ${motel.bairro}",
            overflow: TextOverflow.ellipsis,
          ),

        ],
      ),

    );
  }
}

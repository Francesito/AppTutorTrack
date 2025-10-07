import 'package:flutter/material.dart';
import '../models/alerta.dart';

class AlertCard extends StatelessWidget {
  final Alerta alerta;
  const AlertCard({super.key, required this.alerta});

  @override
  Widget build(BuildContext context) {
    final color = switch (alerta.severity) {
      'high' => Colors.red,
      'med' => Colors.orange,
      _ => Colors.blueGrey,
    };
    return Card(
      child: ListTile(
        leading: Icon(Icons.warning, color: color),
        title: Text(alerta.reason),
        subtitle: Text(alerta.createdAt),
      ),
    );
  }
}

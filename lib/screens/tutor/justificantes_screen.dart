import 'package:flutter/material.dart';

class JustificantesScreen extends StatelessWidget {
  const JustificantesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // MVP: lista estática de demo
    final items = const [
      {'alumno': 'alumno1@demo.com', 'tipo': 'Salud', 'estado': 'pending'},
      {'alumno': 'alumno2@demo.com', 'tipo': 'Personal', 'estado': 'approved'},
    ];
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (_, i) {
        final it = items[i];
        return Card(
          child: ListTile(
            title: Text(it['alumno']!),
            subtitle: Text('Tipo: ${it['tipo']} · Estado: ${it['estado']}'),
            trailing: Wrap(spacing: 8, children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.check_circle, color: Colors.green)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.cancel, color: Colors.red)),
            ]),
          ),
        );
      },
    );
  }
}

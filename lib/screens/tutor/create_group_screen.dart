import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../services/database_service.dart';
import '../../models/group.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final _name = TextEditingController();
  final _code = TextEditingController(text: 'JOIN-${DateTime.now().year}-X');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nombre de grupo')),
        TextField(controller: _code, decoration: const InputDecoration(labelText: 'Código único')),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () async {
            final g = Group(id: const Uuid().v4(), name: _name.text, code: _code.text);
            await DatabaseService.instance._db!.insert('groups', g.toMap()); // acceso interno
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Grupo creado')));
            }
          },
          child: const Text('Crear'),
        )
      ]),
    );
  }
}

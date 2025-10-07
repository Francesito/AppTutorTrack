import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/auth_provider.dart';
import '../../providers/data_provider.dart';
import '../../services/validation_service.dart';
import '../../models/justificante.dart';

class JustificanteScreen extends StatefulWidget {
  const JustificanteScreen({super.key});

  @override
  State<JustificanteScreen> createState() => _JustificanteScreenState();
}

class _JustificanteScreenState extends State<JustificanteScreen> {
  String type = 'Salud';
  File? file;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        DropdownButtonFormField(
          value: type,
          items: const [
            DropdownMenuItem(value: 'Salud', child: Text('Salud')),
            DropdownMenuItem(value: 'Personal', child: Text('Personal')),
          ],
          onChanged: (v) => setState(() => type = v as String),
          decoration: const InputDecoration(labelText: 'Tipo'),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () async {
                final img = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (img != null) setState(() => file = File(img.path));
              },
              icon: const Icon(Icons.upload),
              label: const Text('Evidencia'),
            ),
            const SizedBox(width: 12),
            if (file != null) Text(file!.path.split('/').last),
          ],
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () async {
            await ValidationService.checkJustificantesLimit(() async {
              // Demo: contemos cuantos justificantes ya se enviaron (omitiendo term por simplicidad)
              return 0;
            });
            final j = Justificante(
              id: const Uuid().v4(),
              userId: user.id,
              date: DateTime.now().toIso8601String(),
              type: type,
              evidencePath: file?.path,
            );
            await context.read<DataProvider>().saveJustificante(j);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Justificante enviado')));
            }
          },
          child: const Text('Enviar'),
        ),
      ]),
    );
  }
}

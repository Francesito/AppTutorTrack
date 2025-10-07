import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/data_provider.dart';
import '../../services/database_service.dart';
import '../../widgets/custom_button.dart';

class JoinGroupScreen extends StatefulWidget {
  const JoinGroupScreen({super.key});

  @override
  State<JoinGroupScreen> createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> {
  final _code = TextEditingController();
  String? _msg;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text('Unirme a un grupo con código único'),
          const SizedBox(height: 8),
          TextField(controller: _code, decoration: const InputDecoration(labelText: 'Código del grupo')),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Unirme',
            onPressed: () async {
              final g = await DatabaseService.instance.groupByCode(_code.text.trim());
              setState(() => _msg = g == null ? 'Código inválido' : 'Unido a ${g.name}');
              await context.read<DataProvider>().refreshGroups();
            },
          ),
          if (_msg != null) Padding(padding: const EdgeInsets.only(top: 12), child: Text(_msg!)),
        ],
      ),
    );
  }
}

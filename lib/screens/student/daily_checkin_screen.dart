import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/auth_provider.dart';
import '../../providers/data_provider.dart';
import '../../widgets/emoji_picker.dart';
import '../../utils/helpers.dart';
import '../../models/daily_record.dart';
import '../../services/notification_service.dart';

class DailyCheckinScreen extends StatefulWidget {
  const DailyCheckinScreen({super.key});
  @override
  State<DailyCheckinScreen> createState() => _DailyCheckinScreenState();
}

class _DailyCheckinScreenState extends State<DailyCheckinScreen> {
  int _mood = 3;
  final _note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Check-in diario (1 por día)'),
        const SizedBox(height: 8),
        EmojiPickerAnimated(initial: _mood, onChanged: (v) => _mood = v),
        const SizedBox(height: 12),
        TextField(controller: _note, decoration: const InputDecoration(labelText: 'Nota opcional')),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () async {
            final r = DailyRecord(
              id: const Uuid().v4(),
              userId: user.id,
              date: todayYMD(),
              mood: _mood,
              note: _note.text,
            );
            await context.read<DataProvider>().saveDaily(r);

            // Regla de alerta automática: ánimo < 2
            if (_mood < 2) {
              await NotificationService.instance.sendLocalLike('Alerta bienestar', 'Ánimo muy bajo detectado');
            }
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Check-in guardado')));
            }
          },
          child: const Text('Guardar'),
        ),
      ]),
    );
  }
}

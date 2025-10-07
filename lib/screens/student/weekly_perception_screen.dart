import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/auth_provider.dart';
import '../../providers/data_provider.dart';
import '../../utils/constants.dart';
import '../../utils/helpers.dart';
import '../../models/weekly_perception.dart';

class WeeklyPerceptionScreen extends StatefulWidget {
  const WeeklyPerceptionScreen({super.key});
  @override
  State<WeeklyPerceptionScreen> createState() => _WeeklyPerceptionScreenState();
}

class _WeeklyPerceptionScreenState extends State<WeeklyPerceptionScreen> {
  String subject = kSubjects.first;
  int stress = 3;
  int attendance = 95;
  int mood = 3;
  double grade = 80;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser!;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        DropdownButtonFormField(
          value: subject,
          items: [for (final s in kSubjects) DropdownMenuItem(value: s, child: Text(s))],
          onChanged: (v) => setState(() => subject = v as String),
          decoration: const InputDecoration(labelText: 'Asignatura'),
        ),
        Slider(value: stress.toDouble(), min: 1, max: 5, divisions: 4,
          label: 'Estrés: $stress', onChanged: (v) => setState(() => stress = v.round())),
        Slider(value: attendance.toDouble(), min: 0, max: 100, divisions: 20,
          label: 'Asistencia: $attendance%', onChanged: (v) => setState(() => attendance = v.round())),
        Slider(value: mood.toDouble(), min: 1, max: 5, divisions: 4,
          label: 'Ánimo: $mood', onChanged: (v) => setState(() => mood = v.round())),
        Slider(value: grade, min: 0, max: 100, divisions: 20,
          label: 'Calificación: ${grade.toStringAsFixed(1)}', onChanged: (v) => setState(() => grade = v)),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () async {
            final w = WeeklyPerception(
              id: const Uuid().v4(),
              userId: user.id,
              week: currentIsoWeek(),
              subject: subject,
              stress: stress,
              attendance: attendance,
              mood: mood,
              grade: grade,
            );
            await context.read<DataProvider>().saveWeekly(w);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Percepción semanal guardada')));
            }
          },
          child: const Text('Guardar'),
        )
      ]),
    );
  }
}

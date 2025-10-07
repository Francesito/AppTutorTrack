import 'package:flutter/material.dart';
import '../../services/export_service.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['Alumno', 'Grupo', 'Ánimo Último', 'Asistencia %', 'Promedio'],
      ['ana@demo.com', 'A', '3', '92', '81.3'],
      ['luis@demo.com', 'B', '4', '88', '79.1'],
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        FilledButton(
          onPressed: () async {
            final f = await ExportService.exportPDF('Reporte Grupo', rows);
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PDF listo: ${f.path}')));
          },
          child: const Text('Exportar PDF'),
        ),
        const SizedBox(height: 12),
        FilledButton(
          onPressed: () async {
            final f = await ExportService.exportExcel('Reporte Grupo', rows);
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Excel listo: ${f.path}')));
          },
          child: const Text('Exportar Excel'),
        ),
      ]),
    );
  }
}

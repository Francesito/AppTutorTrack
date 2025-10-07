import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/data_provider.dart';
import '../../widgets/alert_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await context.read<DataProvider>().crearAlerta(
      // Demo: alerta reciente
      // En un flujo real, se insertan al detectar condiciones
      // Aquí solo garantizamos que StreamBuilder-like tenga datos
      // Repite sin duplicar por id en uso real.
      // (omitir para simplicidad)
      // ignore: void_checks
      // (no retorna nada)
      // Placeholder
      // …
      // En esta demo, listAlertas ya trae previas si existen
      // así que solo refrescamos.
      // NOP
      // 
      // Este método se llama y luego listAlertas para mostrar
      // evitar duplicados.
      // 
      // Para no crear alerta dummy cada vez, no haremos nada aquí.
    );
    await context.read<DataProvider>().listAlertas();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DataProvider>();
    final alertas = provider.alertas;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Alertas recientes', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          if (alertas.isEmpty) const Text('Sin alertas'),
          for (final a in alertas) AlertCard(alerta: a),
        ],
      ),
    );
  }
}

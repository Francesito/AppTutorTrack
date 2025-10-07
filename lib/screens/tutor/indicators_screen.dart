import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/stats_provider.dart';
import '../../widgets/custom_chart.dart';

class IndicatorsScreen extends StatelessWidget {
  const IndicatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>();
    final dash = stats.dashboard;
    final ttests = stats.ttests;
    final anova = stats.anova;
    final reg = stats.regression;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Dashboard', style: Theme.of(context).textTheme.titleLarge),
        Text('Check-in: ${dash['checkin_pct']}%'),
        Text('Top estrés: Physics=${dash['top_estres']['Physics']}, Math=${dash['top_estres']['Math']}, Stats=${dash['top_estres']['Stats']}'),
        Text('Justificantes: Salud=${dash['justificantes']['Salud']}, Personal=${dash['justificantes']['Personal']}'),
        const SizedBox(height: 12),
        CustomChartBase64(base64Png: dash['hist_b64'], label: 'Histograma (pre-generado)'),
        const SizedBox(height: 12),
        CustomChartBase64(base64Png: dash['bar_b64'], label: 'Barras (pre-generado)'),
        const Divider(height: 32),
        Text('Pruebas de hipótesis', style: Theme.of(context).textTheme.titleMedium),
        Text('t-test estrés exámenes vs normal: t=${ttests['estres_examenes']['t']}, p=${ttests['estres_examenes']['p']} (sig)'),
        Text('t-test ánimo parciales vs normal: t=${ttests['animo_parciales']['t']}, p=${ttests['animo_parciales']['p']} (sig)'),
        Text('t-test faltas A vs B: t=${ttests['faltas_A_vs_B']['t']}, p=${ttests['faltas_A_vs_B']['p']} (no sig)'),
        const SizedBox(height: 8),
        Text('ANOVA', style: Theme.of(context).textTheme.titleMedium),
        Text('Estrés por asignatura: F=${anova['estres_por_asignatura']['F']}, p=${anova['estres_por_asignatura']['p']} (no sig.)'),
        Text('Ánimo por grupo: F=${anova['animo_por_grupo']['F']}, p=${anova['animo_por_grupo']['p']} (sig.)'),
        const SizedBox(height: 8),
        Text('Regresión lineal: R²=${reg['R2']}, Intercept=${reg['coefs']['Intercept']}, '
            'attendance=${reg['coefs']['attendance']}, mood=${reg['coefs']['mood']}, just=${reg['coefs']['just']}'),
        Text('Correlación ánimo-calificaciones: ${stats.corrMoodGrade} (débil)'),
      ]),
    );
  }
}

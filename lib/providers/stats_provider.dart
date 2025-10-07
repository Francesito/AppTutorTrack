import 'package:flutter/material.dart';
import '../services/stats_service.dart';

class StatsProvider extends ChangeNotifier {
  // Valores precalculados del enunciado
  final Map<String, dynamic> ttests = {
    'estres_examenes': {'t': 5.48, 'p': '<0.001', 'sig': true},
    'animo_parciales': {'t': -2.69, 'p': 0.01, 'sig': true},
    'faltas_A_vs_B': {'t': -1.51, 'p': 0.14, 'sig': false},
  };

  final Map<String, dynamic> anova = {
    'estres_por_asignatura': {'F': 1.81, 'p': 0.17, 'sig': false},
    'animo_por_grupo': {'F': 3.25, 'p': 0.05, 'sig': true},
  };

  final Map<String, dynamic> regression = {
    'R2': 0.13,
    'coefs': {
      'Intercept': 98.44,
      'attendance': -0.06,
      'mood': -3.47,
      'just': -6.42,
    }
  };

  final double corrMoodGrade = 0.03;

  final Map<String, dynamic> dashboard = {
    'checkin_pct': 81.5,
    'top_estres': {'Physics': 3.20, 'Math': 3.17, 'Stats': 2.90},
    'justificantes': {'Salud': 9, 'Personal': 11},
    'hist_b64': 'iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAYAAAA10dzk...',
    'bar_b64': 'iVBORw0KGgoAAAANSUhEUgAAAoAAAAHgCAYAAAA10dzk...',
  };

  Future<double> correlacionDemo(List<double> x, List<double> y) async {
    return StatsService.correlation(x, y);
  }
}

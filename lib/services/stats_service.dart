import 'dart:math';

class StatsService {
  /// Correlación de Pearson simple
  static double correlation(List<double> x, List<double> y) {
    if (x.length != y.length || x.isEmpty) return double.nan;
    final n = x.length;
    final mx = x.reduce((a, b) => a + b) / n;
    final my = y.reduce((a, b) => a + b) / n;
    double num = 0, dx = 0, dy = 0;
    for (var i = 0; i < n; i++) {
      final a = x[i] - mx;
      final b = y[i] - my;
      num += a * b;
      dx += a * a;
      dy += b * b;
    }
    return num / sqrt(dx * dy);
  }
}

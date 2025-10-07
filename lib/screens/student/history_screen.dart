import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Demo: serie simple
    final spots = [
      const FlSpot(0, 3), const FlSpot(1, 4), const FlSpot(2, 2),
      const FlSpot(3, 5), const FlSpot(4, 3),
    ];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(LineChartData(
        minX: 0, maxX: 4, minY: 1, maxY: 5,
        lineBarsData: [LineChartBarData(spots: spots, isCurved: true)],
      )),
    );
  }
}

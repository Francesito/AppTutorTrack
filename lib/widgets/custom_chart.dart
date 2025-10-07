import 'dart:convert';
import 'package:flutter/material.dart';

class CustomChartBase64 extends StatelessWidget {
  final String base64Png;
  final String label;
  const CustomChartBase64({super.key, required this.base64Png, required this.label});

  @override
  Widget build(BuildContext context) {
    final bytes = base64Decode(base64Png.split(',').last);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Image.memory(bytes, fit: BoxFit.contain),
      ],
    );
  }
}

class ValidationService {
  static Future<void> checkJustificantesLimit(
      Future<int> Function() currentCountFn) async {
    final current = await currentCountFn();
    if (current >= 2) {
      throw Exception('Límite de 2 justificantes por cuatrimestre alcanzado.');
    }
  }
}

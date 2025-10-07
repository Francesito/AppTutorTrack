class Alerta {
  final String id;
  final String userId;
  final String createdAt;
  final String reason; // mood<2 | faltas>3 | prom<70
  final String severity; // low|med|high

  Alerta({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.reason,
    required this.severity,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'createdAt': createdAt,
        'reason': reason,
        'severity': severity,
      };

  factory Alerta.fromMap(Map<String, dynamic> m) => Alerta(
        id: m['id'],
        userId: m['userId'],
        createdAt: m['createdAt'],
        reason: m['reason'],
        severity: m['severity'],
      );
}

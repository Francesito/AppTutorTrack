class Justificante {
  final String id;
  final String userId;
  final String date;
  final String type; // Salud | Personal
  final String? evidencePath; // local path imagen
  final String status; // pending|approved|rejected

  Justificante({
    required this.id,
    required this.userId,
    required this.date,
    required this.type,
    this.evidencePath,
    this.status = 'pending',
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'date': date,
        'type': type,
        'evidencePath': evidencePath,
        'status': status,
      };

  factory Justificante.fromMap(Map<String, dynamic> m) => Justificante(
        id: m['id'],
        userId: m['userId'],
        date: m['date'],
        type: m['type'],
        evidencePath: m['evidencePath'],
        status: m['status'],
      );
}

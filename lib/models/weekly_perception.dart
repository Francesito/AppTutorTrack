class WeeklyPerception {
  final String id;
  final String userId;
  final String week; // ISO week e.g. 2025-W40
  final String subject; // Matemáticas, Física, Estadística
  final int stress; // escala 1-5
  final int attendance; // %
  final int mood; // 1-5
  final double grade; // promedio parcial

  WeeklyPerception({
    required this.id,
    required this.userId,
    required this.week,
    required this.subject,
    required this.stress,
    required this.attendance,
    required this.mood,
    required this.grade,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'week': week,
        'subject': subject,
        'stress': stress,
        'attendance': attendance,
        'mood': mood,
        'grade': grade,
      };

  factory WeeklyPerception.fromMap(Map<String, dynamic> m) => WeeklyPerception(
        id: m['id'],
        userId: m['userId'],
        week: m['week'],
        subject: m['subject'],
        stress: m['stress'],
        attendance: m['attendance'],
        mood: m['mood'],
        grade: (m['grade'] as num).toDouble(),
      );
}

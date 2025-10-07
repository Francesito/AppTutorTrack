class DailyRecord {
  final String id;
  final String userId;
  final String date; // yyyy-MM-dd
  final int mood; // 1-5
  final String? note;

  DailyRecord({
    required this.id,
    required this.userId,
    required this.date,
    required this.mood,
    this.note,
  });

  Map<String, dynamic> toMap() =>
      {'id': id, 'userId': userId, 'date': date, 'mood': mood, 'note': note};

  factory DailyRecord.fromMap(Map<String, dynamic> m) => DailyRecord(
        id: m['id'],
        userId: m['userId'],
        date: m['date'],
        mood: m['mood'],
        note: m['note'],
      );
}

class AlumnoGroup {
  final String id;
  final String userId;
  final String groupId;
  final String term; // cuatrimestre-id
  AlumnoGroup({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.term,
  });

  Map<String, dynamic> toMap() =>
      {'id': id, 'userId': userId, 'groupId': groupId, 'term': term};
  factory AlumnoGroup.fromMap(Map<String, dynamic> m) => AlumnoGroup(
        id: m['id'],
        userId: m['userId'],
        groupId: m['groupId'],
        term: m['term'],
      );
}

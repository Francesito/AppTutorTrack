class Group {
  final String id; // uuid
  final String name; // A/B/C
  final String code; // código único para unirse
  Group({required this.id, required this.name, required this.code});

  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'code': code};
  factory Group.fromMap(Map<String, dynamic> m) =>
      Group(id: m['id'], name: m['name'], code: m['code']);
}

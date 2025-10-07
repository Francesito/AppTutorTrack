class AppUser {
  final String id;
  final String email;
  final String role; // "alumno" | "tutor"
  final String? displayName;
  final String passwordHash; // bcrypt o hash simple para demo

  AppUser({
    required this.id,
    required this.email,
    required this.role,
    required this.passwordHash,
    this.displayName,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'role': role,
        'displayName': displayName,
        'passwordHash': passwordHash,
      };

  factory AppUser.fromMap(Map<String, dynamic> m) => AppUser(
        id: m['id'],
        email: m['email'],
        role: m['role'],
        displayName: m['displayName'],
        passwordHash: m['passwordHash'],
      );
}

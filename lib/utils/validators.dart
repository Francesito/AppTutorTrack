bool isValidEmail(String s) => RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(s);
bool isStrongPassword(String s) => s.length >= 8 && RegExp(r'\d').hasMatch(s);

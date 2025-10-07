import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? currentUser;

  Future<void> register(String email, String password, String role) async {
    final user = await AuthService.instance.register(email, password, role);
    currentUser = user;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final user = await AuthService.instance.login(email, password);
    currentUser = user;
    notifyListeners();
  }

  Future<void> logout() async {
    await AuthService.instance.logout();
    currentUser = null;
    notifyListeners();
  }
}

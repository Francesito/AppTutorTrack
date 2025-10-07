import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/common/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      colorSchemeSeed: const Color(0xFF2196F3),
      useMaterial3: true,
      brightness: Brightness.light,
    );
    final dark = ThemeData(
      colorSchemeSeed: const Color(0xFF4CAF50),
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    return MaterialApp(
      title: 'AppTutorTrack',
      theme: theme,
      darkTheme: dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Consumer<AuthProvider>(
        builder: (_, auth, __) =>
            auth.currentUser == null ? const LoginScreen() : const HomeScreen(),
      ),
    );
  }
}

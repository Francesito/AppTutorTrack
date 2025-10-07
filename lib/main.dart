import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'providers/app_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/data_provider.dart';
import 'providers/stats_provider.dart';
import 'services/database_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // Requiere google-services/GoogleService-Info
  } catch (_) {
    // Permite correr sin Firebase configurado (solo offline)
    debugPrint('Firebase no inicializado, corriendo en modo offline.');
  }
  await DatabaseService.instance.init(); // SQLite + seed de datos
  await NotificationService.instance.init(); // FCM (si está disponible)
  runApp(const AppBootstrap());
}

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
        ChangeNotifierProvider(create: (_) => StatsProvider()),
      ],
      child: const App(),
    );
  }
}

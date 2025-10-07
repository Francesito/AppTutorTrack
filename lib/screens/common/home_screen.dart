import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../providers/auth_provider.dart';
import '../student/join_group_screen.dart';
import '../student/daily_checkin_screen.dart';
import '../student/weekly_perception_screen.dart';
import '../student/history_screen.dart';
import '../student/notifications_screen.dart';
import '../tutor/create_group_screen.dart';
import '../tutor/dashboard_screen.dart';
import '../tutor/justificantes_screen.dart';
import '../tutor/reports_screen.dart';
import '../tutor/indicators_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final isTutor = auth.currentUser?.role == 'tutor';
    final tabs = isTutor
        ? const [
            _Tab('Dashboard', Icons.dashboard, DashboardScreen()),
            _Tab('Crear Grupo', Icons.group_add, CreateGroupScreen()),
            _Tab('Justificantes', Icons.fact_check, JustificantesScreen()),
            _Tab('Indicadores', Icons.insights, IndicatorsScreen()),
            _Tab('Reportes', Icons.picture_as_pdf, ReportsScreen()),
          ]
        : const [
            _Tab('Unirme', Icons.group, JoinGroupScreen()),
            _Tab('Check-in', Icons.emoji_emotions, DailyCheckinScreen()),
            _Tab('Semanal', Icons.view_week, WeeklyPerceptionScreen()),
            _Tab('Historial', Icons.show_chart, HistoryScreen()),
            _Tab('Notifs', Icons.notifications, NotificationsScreen()),
          ];

    final app = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Hola, ${auth.currentUser?.displayName ?? 'Usuario'}'),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => auth.logout()),
        ],
      ),
      body: tabs[app.bottomIndex].screen,
      bottomNavigationBar: NavigationBar(
        selectedIndex: app.bottomIndex,
        onDestinationSelected: (i) => context.read<AppProvider>().setIndex(i),
        destinations: [
          for (final t in tabs) NavigationDestination(icon: Icon(t.icon), label: t.title)
        ],
      ),
    );
  }
}

class _Tab {
  final String title;
  final IconData icon;
  final Widget screen;
  const _Tab(this.title, this.icon, this.screen);
}

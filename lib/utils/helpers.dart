import 'package:intl/intl.dart';

String todayYMD() => DateFormat('yyyy-MM-dd').format(DateTime.now());

String currentIsoWeek() {
  final now = DateTime.now();
  final week = int.parse(DateFormat('w').format(now));
  return '${now.year}-W${week.toString().padLeft(2, '0')}';
}

import 'package:flutter/material.dart';
import '../models/group.dart';
import '../models/daily_record.dart';
import '../models/weekly_perception.dart';
import '../models/justificante.dart';
import '../models/alerta.dart';
import '../services/database_service.dart';

class DataProvider extends ChangeNotifier {
  List<Group> groups = [];
  List<Alerta> alertas = [];

  Future<void> refreshGroups() async {
    groups = await DatabaseService.instance.listGroups();
    notifyListeners();
  }

  Future<void> saveDaily(DailyRecord r) async {
    await DatabaseService.instance.insertDaily(r);
    notifyListeners();
  }

  Future<void> saveWeekly(WeeklyPerception w) async {
    await DatabaseService.instance.insertWeekly(w);
    notifyListeners();
  }

  Future<void> saveJustificante(Justificante j) async {
    await DatabaseService.instance.insertJustificante(j);
    notifyListeners();
  }

  Future<void> crearAlerta(Alerta a) async {
    await DatabaseService.instance.insertAlerta(a);
    alertas = await DatabaseService.instance.listAlertas();
    notifyListeners();
  }
}

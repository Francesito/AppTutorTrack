import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/group.dart';
import '../models/user.dart';
import '../models/daily_record.dart';
import '../models/weekly_perception.dart';
import '../models/justificante.dart';
import '../models/alerta.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService instance = DatabaseService._();

  static const _dbName = 'apptutortrack.db';
  Database? _db;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = p.join(dir.path, _dbName);
    _db = await openDatabase(path, version: 1, onCreate: _onCreate);
    await _seedIfNeeded();
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE,
        role TEXT,
        displayName TEXT,
        passwordHash TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE groups(
        id TEXT PRIMARY KEY,
        name TEXT,
        code TEXT UNIQUE
      );
    ''');
    await db.execute('''
      CREATE TABLE alumno_group(
        id TEXT PRIMARY KEY,
        userId TEXT,
        groupId TEXT,
        term TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE daily_record(
        id TEXT PRIMARY KEY,
        userId TEXT,
        date TEXT,
        mood INTEGER,
        note TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE weekly_perception(
        id TEXT PRIMARY KEY,
        userId TEXT,
        week TEXT,
        subject TEXT,
        stress INTEGER,
        attendance INTEGER,
        mood INTEGER,
        grade REAL
      );
    ''');
    await db.execute('''
      CREATE TABLE justificante(
        id TEXT PRIMARY KEY,
        userId TEXT,
        date TEXT,
        type TEXT,
        evidencePath TEXT,
        status TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE alerta(
        id TEXT PRIMARY KEY,
        userId TEXT,
        createdAt TEXT,
        reason TEXT,
        severity TEXT
      );
    ''');
  }

  Future<void> _seedIfNeeded() async {
    final c = (await _db!.query('groups')).length;
    if (c > 0) return;

    // Grupos A/B/C
    final groups = [
      Group(id: 'gA', name: 'A', code: 'JOIN-A-2025'),
      Group(id: 'gB', name: 'B', code: 'JOIN-B-2025'),
      Group(id: 'gC', name: 'C', code: 'JOIN-C-2025'),
    ];
    for (final g in groups) {
      await _db!.insert('groups', g.toMap());
    }

    // Cargar 50 alumnos simulados desde CSV
    final csv = await rootBundle.loadString('assets/data/simulated_data.csv');
    final lines = LineSplitter.split(csv).toList();
    for (var i = 1; i < lines.length; i++) {
      final cols = lines[i].split(',');
      final id = cols[0];
      final email = cols[1];
      final role = cols[2];
      final display = cols[3];
      final groupId = cols[4];
      final pwHash = cols[5];
      await _db!.insert('users', {
        'id': id,
        'email': email,
        'role': role,
        'displayName': display,
        'passwordHash': pwHash,
      });
      await _db!.insert('alumno_group', {
        'id': 'ag_$id',
        'userId': id,
        'groupId': groupId,
        'term': '2025Q4',
      });
    }
  }

  // Users
  Future<AppUser?> findUserByEmail(String email) async {
    final r = await _db!.query('users', where: 'email=?', whereArgs: [email], limit: 1);
    if (r.isEmpty) return null;
    return AppUser.fromMap(r.first);
    }

  Future<void> upsertUser(AppUser u) async {
    await _db!.insert('users', u.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Groups
  Future<List<Group>> listGroups() async {
    final r = await _db!.query('groups');
    return r.map((e) => Group.fromMap(e)).toList();
  }

  Future<Group?> groupByCode(String code) async {
    final r = await _db!.query('groups', where: 'code=?', whereArgs: [code], limit: 1);
    if (r.isEmpty) return null;
    return Group.fromMap(r.first);
  }

  // Daily
  Future<void> insertDaily(DailyRecord d) async {
    // 1 check-in/día
    final exists = await _db!.query('daily_record',
        where: 'userId=? AND date=?', whereArgs: [d.userId, d.date], limit: 1);
    if (exists.isNotEmpty) {
      await _db!.update('daily_record', d.toMap(),
          where: 'id=?', whereArgs: [exists.first['id']]);
    } else {
      await _db!.insert('daily_record', d.toMap());
    }
  }

  // Weekly
  Future<void> insertWeekly(WeeklyPerception w) async {
    await _db!.insert('weekly_perception', w.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Justificantes (máx 2/cuatrimestre -> validar en ValidationService)
  Future<void> insertJustificante(Justificante j) async {
    await _db!.insert('justificante', j.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Alertas
  Future<void> insertAlerta(Alerta a) async {
    await _db!.insert('alerta', a.toMap());
  }

  Future<List<Alerta>> listAlertas() async {
    final r = await _db!.query('alerta', orderBy: 'createdAt DESC');
    return r.map((e) => Alerta.fromMap(e)).toList();
  }
}

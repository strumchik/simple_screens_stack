import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBDriver {
  Future<Database> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      join(await getDatabasesPath(), 'appdb.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, surname TEXT,'
          'email TEXT, gender INTEGER, birthdate TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<int> insert(String table, Map<String, dynamic> values) async {
    final db = await init();
    var newUserId = db.insert(table, values, conflictAlgorithm: ConflictAlgorithm.rollback);
    return newUserId;
  }

  Future<List<Map<String, dynamic>>> select(String table, String where) async {
    final db = await init();
    if (where.isNotEmpty) {
      return await db.query(table, where: where);
    } else {
      return await db.query(table);
    }
  }

  void update(String table, Map<String, dynamic> values, String where) async {
    final db = await init();
    await db.update(table, values, where: where);
  }

  Future<int> delete(String table, String where) async {
    final db = await init();
    final delAmount = await db.delete(table, where: where);
    return delAmount;
  }
}

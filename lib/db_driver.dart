import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:layouts_and_ui/user.dart';
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

  void insertUser(User user) async {
    final db = await init();
    debugPrint(db.toString());
    int id = await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint("ID = $id");
  }

  Future<List<User>> users() async {
    final db = await init();
    final List<Map<String, dynamic>> maps = await db.query('users');

    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        surname: maps[i]['surname'],
        email: maps[i]['email'],
        birthdate: DateTime.parse(maps[i]['birthdate']),
        gender: maps[i]['gender'],
      );
    });
  }
}

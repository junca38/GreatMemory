import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  /// opening or creating the database
  static Future<Database> database() async {
    /// get the db path first
    final dbPath = await sql.getDatabasesPath();
    final pather = path.join(dbPath, 'places.db');
    var db;

    try {
      db = await sql.openDatabase(pather, onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)");
      }, version: 1);
    } catch (e) {
      print(e);
      print("create or open error");
    }
    return db;
  }

  /// sql insert
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    try {
      await db.insert(table, data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
      print(
          "insert error, probably something wrong with the table. You might want to check if the table exist or not.");
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return await db.query(table);
  }
}

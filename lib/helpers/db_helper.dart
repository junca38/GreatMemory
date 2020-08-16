import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  /// opening or creating the database
  static Future<Database> database() async {
    /// get the db path first
    final dbPath = await sql.getDatabasesPath();
    Database db;

    try {
      db = await sql.openDatabase(path.join(dbPath, 'places.db'),
          onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_long REAL, address TEXT)");
      }, version: 1);
    } catch (e) {
      print(e);
      print("create or open db error");
    }
    return db;
  }

  /// Given the tablename and the data, do sql insert
  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    try {
      await db.insert(table, data,
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
    } catch (e) {
      print(e);
      print("insert error, probably something wrong with the table.");
    }
  }

  /// return all records inside a table
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return await db.query(table);
  }
}

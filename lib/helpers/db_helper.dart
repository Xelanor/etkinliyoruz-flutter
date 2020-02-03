import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'favorites.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_favorites(_id TEXT PRIMARY KEY, name TEXT, image TEXT, description TEXT, category TEXT, date TEXT, eventAge TEXT, eventPrice TEXT, eventLink TEXT, location TEXT, place TEXT, latitude TEXT, longitude TEXT, isFavorite INTEGER)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> getFavorites(String table) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT * FROM $table WHERE isFavorite = 1');
  }

  static Future<List<Map<String, dynamic>>> getFavoriteDataById(
      String table, String id) async {
    final db = await DBHelper.database();
    return db.rawQuery('SELECT isFavorite FROM $table WHERE _id = "$id"');
  }

  static Future<void> deleteDB() async {
    var databasesPath = await sql.getDatabasesPath();
    String pathws = path.join(databasesPath, 'favorites.db');

    await sql.deleteDatabase(pathws);
  }
}

import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'cart.db'),
        onCreate: (db, version) {    
          return db.execute(
            'CREATE TABLE user_cart(id TEXT PRIMARY KEY, title TEXT, amount TEXT, info TEXT)',
          );
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> remove(String table, String id) async {
    final db = await DBHelper.database();
    await db.execute(
      'DELETE FROM ' + table + ' WHERE id = ' + id
    );
  }
  
  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}

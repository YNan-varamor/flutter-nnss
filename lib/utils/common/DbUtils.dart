import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:ns/config/DbConf.dart';
import 'dart:async';

class DbUtils {
  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    String path = await getDatabasesPath();
    path = join(path, DbConf.dbName);
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(DbConf.sqlShelf);
    await db.execute(DbConf.sqlReadSet);

    Map<String, dynamic> settings = new Map();
    settings["bgColor"] = 0;
    settings["fontSize"] = 15;
    db.insert("tSet", settings);
  }

  closeDb() {
    if (_db != null || _db.isOpen) {
      _db.close();
      _db = null;
    }
  }

  Future<int> insert(String dbname, Map<String, dynamic> obj) async {
    var dbClient = await db;
    var ret = await dbClient.insert(dbname, obj);
    return ret;
  }

  Future<int> delete(sql) async {
    var dbClient = await db;
    var ret = await dbClient.rawDelete(sql);
    return ret;
  }

  Future<int> update(sql) async {
    var dbClient = await db;
    var ret = await dbClient.rawUpdate(sql);
    return ret;
  }

  Future<List<Map>> rawQuery(sql) async {
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery(sql);
    return list;
  }

  Future<List<Map>> query(
    String table,
    List<String> columns,
    String where,
    List<String> wherearg,
  ) async {
    var dbClient = await db;
    List<Map> list = await dbClient.query(
      table,
      columns: columns,
      where: where,
      whereArgs: wherearg,
    );
    return list;
  }
}

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

import 'package:sqlitetodo/models/todo_model.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;
  static const table = 'my_table';

  static const columnId = '_id';
  static const columnActivity = 'activity';
  static const columnDescription = 'description';
  static const columnTime = 'time';
  static const columnDay = 'day';
  static const columnisDone = 'isDone';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnActivity TEXT NOT NULL,
            $columnDescription TEXT NOT NULL,
            $columnTime TEXT NOT NULL,
            $columnDay TEXT NOT NULL,
            $columnisDone INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    print(row);
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  Future<List<TodoModel>> queryAllRows() async {
    Database? db = await instance.database;
    var res = await db!.query(table);
    List<TodoModel> result =
        res.isNotEmpty ? res.map((e) => TodoModel.fromJson(e)).toList() : [];

    return result;
  }

  Future<int> update(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    return await db!
        .update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database? db = await instance.database;
    return await db!.delete(table);
  }

  Future<Map<String, dynamic>> findById(int id) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> result =
        await db!.query(table, where: '$columnId = ?', whereArgs: [id]);
    return result.first;
  }
}

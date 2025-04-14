import 'dart:async';
import 'package:flutter_references/utils/dataModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  String tableName = "TableName", databaseName = "my_database.db";
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, '
              'name TEXT, '
              'age TEXT, '
              'imgUrl TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertItem(DataModel model) async {
    final db = await database;
    await db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DataModel>> retrieveItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (position) {
      return DataModel.fromMap(maps[position]);
    });
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

/*

  Future<void> updateItem(int id, String name) async {
    final db = await database;
    await db.update(
      'items',
      {'name': name},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

*/

}
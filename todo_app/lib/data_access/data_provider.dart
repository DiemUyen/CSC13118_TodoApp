import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataProvider {
  Database? _database;
  final dbName = 'todo_list.db';
  final version = 1;

  DataProvider._createInstance();
  static final DataProvider dataProvider = DataProvider._createInstance();

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future _initDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: version,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Task(taskId INTEGER PRIMARY KEY, name TEXT, description TEXT, toDo INTEGER, toDoTime TEXT, priority INTEGER'
        );
        await db.execute(
          'CREATE TABLE Notification(notificationId INTEGER PRIMARY KEY, title TEXT, description TEXT, time TEXT, taskId INTEGER'
        );
      }
    );
  }

  Future close() async => _database?.close();
}
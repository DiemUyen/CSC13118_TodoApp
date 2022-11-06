import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/notification.dart';
import 'package:todo_app/models/task.dart';

class DataProvider {
  Database? _database;
  final dbName = 'todo_list.db';
  final version = 1;

  DataProvider._createInstance();
  static final DataProvider dataProvider = DataProvider._createInstance();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDb();
    return _database!;
  }

  Future _initDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), dbName),
      version: version,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Task(taskId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, description TEXT, toDoTime TEXT, priority INTEGER)'
        );
        await db.execute(
          'CREATE TABLE Notification(notificationId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT, time TEXT, taskId INTEGER)'
        );
      }
    );
  }

  Future close() async {
    final db = await DataProvider.dataProvider.database;
    _database = null;
    return db.close();
  }

  Future<int> insertTask(Task task) async {
    final db = await DataProvider.dataProvider.database;
    int id = await db.insert('Task', task.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<Task>> getTask(int id) async {
    final db = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('Task', where: 'taskId = ?', whereArgs: [id]);
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<List<Task>> getAllTasks() async {
    final db = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('Task');
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<void> deleteTask(int id) async {
    final db = await DataProvider.dataProvider.database;
    await db.delete('Task',where: 'taskId = ?',whereArgs: [id]);
  }

  Future<void> updateTask(Task task) async {
    final db = await DataProvider.dataProvider.database;
    await db.update('Task', task.toMap(), where: 'taskId = ?', whereArgs: [task.taskId]);
  }

  Future<int> insertNotification(AppNotification notification) async {
    final db = await DataProvider.dataProvider.database;
    int id = await db.insert('Notification', notification.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future getNotifications(int taskId) async {
    final db = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('Notification', where: 'taskId = ?', whereArgs: [taskId]);
    final records = List.generate(maps.length, (index) => AppNotification.fromMap(maps[index]));
    return records[0].notificationId;
  }

  Future<List<AppNotification>> getAllNotifications() async {
    final db = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await db.query('Notification');

    return List.generate(maps.length, (index) => AppNotification.fromMap(maps[index]));
  }

  Future<void> deleteNotification(int notificationId) async {
    final db = await DataProvider.dataProvider.database;
    await db.delete('Notification',where: 'notificationId = ?',whereArgs: [notificationId]);
  }

  Future<void> updateNotification(AppNotification notification) async {
    final db = await DataProvider.dataProvider.database;
    await db.update('Notification', notification.toMap(), where: 'notificationId = ?', whereArgs: [notification.taskId]);
  }
}
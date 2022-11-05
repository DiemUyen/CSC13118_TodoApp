import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/task.dart';

class TaskDAO {
  late final Database database;

  Future<void> insert(Task task) async {
    database = await DataProvider.dataProvider.database;
    await database.insert('Task', task.toMap(),);
  }

  Future<List<Task>> getTask(int id) async {
    database = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await database.query('Task', where: 'id = ?', whereArgs: [id]);
    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<List<Task>> getAllTasks() async {
    //await open(databaseName);
    database = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await database.query('Task');
    //await close();

    return List.generate(maps.length, (index) => Task.fromMap(maps[index]));
  }

  Future<void> delete(int id) async {
    //await open(databaseName);
    database = await DataProvider.dataProvider.database;
    await database.delete('Task',where: 'taskId = ?',whereArgs: [id]);
    //await close();
  }

  Future<void> update(Task task) async {
    database = await DataProvider.dataProvider.database;
    await database.update('Task', task.toMap(), where: 'id = ?', whereArgs: [task.taskId]);
  }

  Future<void> close() async {
    database = await DataProvider.dataProvider.close();
  }
}
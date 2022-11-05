import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/task.dart';

class TaskDAO {
  Database? database;
  final databaseName = 'todo_list.db';
  
  Future open(String databaseName) async {
    database = await openDatabase(
      join(await getDatabasesPath()), 
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Task(taskId INTEGER PRIMARY KEY, name TEXT, description TEXT, toDo INTEGER, toDoTime TEXT, projectId INTEGER',
        );
      }
    );
  }

  Future close() async => database?.close();

  void insert(Task task) async {
    await open(databaseName);
    await database?.insert('Task', task.toMap(),);
    await close();
  }

  Future<List<Task>> getTasks() async {
    await open(databaseName);
    final List<Map<String, dynamic>>? maps = await database?.query('Task');
    await close();
    
    return List.generate(maps!.length, (index) => Task.fromMap(maps[index]));
  }
  
  void delete(int id) async {
    await open(databaseName);
    await database?.delete('Task',where: 'taskId = ?',whereArgs: [id]);
    await close();
  }
}
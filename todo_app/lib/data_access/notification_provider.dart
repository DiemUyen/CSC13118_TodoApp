import 'package:sqflite/sqflite.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/notification.dart';

class NotificationDAO {
  late final Database database;

  Future<int> insert(AppNotification notification) async {
    database = await DataProvider.dataProvider.database;
    int id = await database.insert('Notification', notification.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<List<AppNotification>> getAllNotifications() async {
    database = await DataProvider.dataProvider.database;
    final List<Map<String, dynamic>> maps = await database.query('Notification');

    return List.generate(maps.length, (index) => AppNotification.fromMap(maps[index]));
  }

  Future<void> delete(int id) async {
    database = await DataProvider.dataProvider.database;
    await database.delete('Notification',where: 'notificationId = ?',whereArgs: [id]);
  }

  Future<void> update(AppNotification notification) async {
    database = await DataProvider.dataProvider.database;
    await database.update('Notification', notification.toMap(), where: 'id = ?', whereArgs: [notification.taskId]);
  }

  Future<void> close() async {
    database = await DataProvider.dataProvider.close();
  }
}
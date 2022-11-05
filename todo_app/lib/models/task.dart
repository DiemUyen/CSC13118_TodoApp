import 'package:todo_app/models/priority.dart';

class Task {
  final int taskId;
  final String name;
  final String description;
  final bool toDo;
  final DateTime toDoTime;
  final PriorityTask priority;

  const Task ({
    required this.taskId,
    required this.name,
    required this.description,
    required this.toDo,
    required this.toDoTime,
    required this.priority
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'name': name,
      'description': description,
      'toDo': toDo == true ? 1 : 0,
      'toDoTime': toDoTime.toIso8601String(),
      'priority': priority,
    };
  }

  factory Task.fromMap(Map<String, dynamic> task) {
    return Task(
      taskId: task['taskId'],
      name: task['name'],
      description: task['description'],
      toDo: task['toDo'] == 1,
      toDoTime: DateTime.parse(task['toDoTime']),
      priority: PriorityTask.values[task['priority']]
    );
  }
}
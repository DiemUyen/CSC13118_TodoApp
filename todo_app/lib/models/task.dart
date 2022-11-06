import 'package:todo_app/models/priority.dart';

class Task {
  int? taskId;
  final String name;
  final String description;
  final DateTime toDoTime;
  final PriorityTask priority;

  Task ({
    this.taskId,
    required this.name,
    required this.description,
    required this.toDoTime,
    required this.priority
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'name': name,
      'description': description,
      'toDoTime': toDoTime.toIso8601String(),
      'priority': priority.index,
    };
  }

  factory Task.fromMap(Map<String, dynamic> task) {
    return Task(
      taskId: task['taskId'],
      name: task['name'],
      description: task['description'],
      toDoTime: DateTime.parse(task['toDoTime']),
      priority: PriorityTask.values[task['priority']]
    );
  }
}

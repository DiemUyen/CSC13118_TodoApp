import 'package:todo_app/models/task.dart';

class TaskList {
  final List<Task> tasks;

  const TaskList({
    required this.tasks
  });

  void addTask(Task task) {
    tasks.add(task);
  }

  bool removeTask(Task task) {
    return tasks.remove(task);
  }
}
class Task {
  final int taskId;
  final String name;
  final String description;
  final bool toDo;
  final DateTime toDoTime;
  final int projectId;

  const Task ({
    required this.taskId,
    required this.name,
    required this.description,
    required this.toDo,
    required this.toDoTime,
    required this.projectId
  });

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'name': name,
      'description': description,
      'toDo': toDo == true ? 1 : 0,
      'toDoTime': toDoTime.toIso8601String(),
      'projectId': projectId,
    };
  }

  factory Task.fromMap(Map<String, dynamic> task) {
    return Task(
      taskId: task['taskId'],
      name: task['name'],
      description: task['description'],
      toDo: task['toDo'] == 1,
      toDoTime: DateTime.parse(task['toDoTime']),
      projectId: task['projectId']
    );
  }
}
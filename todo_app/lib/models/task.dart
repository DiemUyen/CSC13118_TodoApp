class Task {
  final int id;
  final String name;
  final String description;
  final bool toDo;
  final DateTime toDoTime;
  final String projectName;

  const Task ({
    required this.id,
    required this.name,
    required this.description,
    required this.toDo,
    required this.toDoTime,
    required this.projectName
  });
}
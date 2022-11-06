import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({Key? key, required this.todo}) : super(key: key);

  final Task todo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteGenerator.detailTaskPage, arguments: todo.taskId.toString());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: !todo.toDo,
                activeColor: AppTheme.lightTheme(null).colorScheme.tertiary,
                onChanged: (bool? value) {
                  //todo.toDo = value;
                },
              ),
              const SizedBox(width: 8,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.name,
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    todo.description.isEmpty? const SizedBox(height: 0,) : Text(
                      todo.description,
                      style: context.bodyLarge,
                    ),
                    Text(
                      DateFormat('dd MM yyyy').format(DateTime.now()) == DateFormat('dd MM yyyy').format(todo.toDoTime)
                          ? DateFormat('h:mm a').format(todo.toDoTime)
                          : DateFormat('h:mm a, E d MMM yyyy').format(todo.toDoTime),
                      style: context.bodyLarge?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppTheme.lightTheme(null).colorScheme.primary
                      ),
                    ),
                    Text(
                      todo.priority.name.toUpperCase(),
                      style: context.bodyLarge?.copyWith(
                        color: AppTheme.lightTheme(null).colorScheme.tertiary
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

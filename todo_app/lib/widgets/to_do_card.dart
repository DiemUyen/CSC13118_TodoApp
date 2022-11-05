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
                      style: context.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      todo.description,
                      style: context.bodyMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          DateTime.now().difference(todo.toDoTime).inDays == 0
                              ? DateFormat('hh:mm').format(todo.toDoTime)
                              : DateFormat('hh:mm, E d MMM yyyy').format(todo.toDoTime),
                          style: context.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: AppTheme.lightTheme(null).colorScheme.primary
                          ),
                        ),
                        Text(
                          todo.priority.name.toUpperCase(),
                          style: context.bodyMedium?.copyWith(
                            color: AppTheme.lightTheme(null).colorScheme.tertiary
                          ),
                        ),
                      ],
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

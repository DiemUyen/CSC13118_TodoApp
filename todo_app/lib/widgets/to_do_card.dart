import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({Key? key, required this.isChecked, required this.todo}) : super(key: key);

  final bool isChecked;
  final Task todo;

  @override
  Widget build(BuildContext context) {
    int projectNameMaxLength;

    if (todo.projectName.length > 25) {
      projectNameMaxLength = 25;
    }
    else {
      projectNameMaxLength = todo.projectName.length;
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (bool? value) {},
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
                        '${todo.toDoTime.hour} : ${todo.toDoTime.minute}',
                        style: context.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppTheme.lightTheme(null).colorScheme.primary
                        ),
                      ),
                      Text(
                        todo.projectName.substring(0, projectNameMaxLength - 1),
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
    );
  }
}

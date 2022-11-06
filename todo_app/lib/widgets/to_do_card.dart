import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({Key? key, required this.todo, required this.onChangedCallback,}) : super(key: key);

  final Task todo;
  final void Function(int id) onChangedCallback;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  
  var isChecked = false;
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RouteGenerator.detailTaskPage, arguments: widget.todo.taskId.toString());
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: isChecked,
                activeColor: AppTheme.lightTheme(null).colorScheme.tertiary,
                onChanged: (bool? value) {
                  if (value == true) {
                    setState(() {
                      widget.onChangedCallback(widget.todo.taskId!);
                      isChecked = value!;
                    });
                  }
                },
              ),
              const SizedBox(width: 8,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo.name,
                      style: context.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    widget.todo.description.isEmpty? const SizedBox(height: 0,) : Text(
                      widget.todo.description,
                      style: context.bodyLarge,
                    ),
                    Text(
                      DateFormat('dd MM yyyy').format(DateTime.now()) == DateFormat('dd MM yyyy').format(widget.todo.toDoTime)
                          ? DateFormat('h:mm a').format(widget.todo.toDoTime)
                          : DateFormat('h:mm a, E d MMM yyyy').format(widget.todo.toDoTime),
                      style: context.bodyLarge?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppTheme.lightTheme(null).colorScheme.primary
                      ),
                    ),
                    Text(
                      widget.todo.priority.name.toUpperCase(),
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



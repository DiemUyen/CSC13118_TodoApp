import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/extensions.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({Key? key}) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  final todo = Task(taskId: 1, name: 'Thiet ke giao dien', description: 'Ve prototype cho ung dung UniRide', toDo: true, toDoTime: DateTime.now(), projectId: 2);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.name,
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                todo.description,
                style: context.bodyMedium,
              ),
              const SizedBox(height: 8,),
              Text(
                DateFormat('hh:mm, d MMM').format(todo.toDoTime),
                style: context.bodyMedium,
              ),
              const SizedBox(height: 8,),
              Text(
                '${todo.projectId}',
                style: context.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}

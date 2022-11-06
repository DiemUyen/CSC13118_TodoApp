import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class EditingTaskPage extends StatefulWidget {
  const EditingTaskPage({Key? key, required this.task}) : super(key: key);

  final Task task;

  @override
  State<EditingTaskPage> createState() => _EditingTaskPageState();
}

class _EditingTaskPageState extends State<EditingTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/extensions.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({Key? key, required this.taskId}) : super(key: key);

  final String taskId;

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  final dataProvider = DataProvider.dataProvider;
  Task? task;

  @override
  void initState() {
    getTask().then((value) {
      setState(() {
        task = value[0];
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    dataProvider.close();
    super.dispose();
  }

  Future<List<Task>> getTask() async {
    int id = int.parse(widget.taskId);
    return await dataProvider.getTask(id);
  }

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
                '${task?.name}',
                style: context.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8,),
              Text(
                '${task?.description}',
                style: context.bodyMedium,
              ),
              const SizedBox(height: 8,),
              Text(
                DateFormat('hh:mm, d MMM').format(task != null? task!.toDoTime:DateTime.now()),
                style: context.bodyMedium,
              ),
              const SizedBox(height: 8,),
              Text(
                '${task?.priority}',
                style: context.bodyMedium,
              )
            ],
          ),
        ),
      ),
    );
  }
}



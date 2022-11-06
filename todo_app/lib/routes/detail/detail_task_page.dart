import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class DetailTaskPage extends StatefulWidget {
  const DetailTaskPage({Key? key, required this.taskId}) : super(key: key);

  final String taskId;

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  final dataProvider = DataProvider.dataProvider;
  Future<List<Task>>? _dataFuture;
  late Task task;

  @override
  void initState() {
    _dataFuture = getTask();
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
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SafeArea(
            child: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          task = snapshot.data[0];
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.penFancy,
                          color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          task.name,
                          style: context.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.alignLeft,
                          color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          task.description.isNotEmpty? task.description : 'No description',
                          style: context.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.calendar,
                          color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          DateFormat('hh:mm, d MMM').format(task.toDoTime),
                          style: context.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.flag,
                          color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          task.priority.name.toUpperCase(),
                          style: context.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.check,
                          color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8,),
                        Text(
                          task.toDo? 'TO DO' : 'COMPLETED',
                          style: context.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            body: Container(),
          ),
        );
      },
    );
  }
}



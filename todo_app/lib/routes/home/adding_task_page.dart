import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/notification.dart';
import 'package:todo_app/models/priority.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/service/local_notice_service.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class AddingTaskPage extends StatefulWidget {
  const AddingTaskPage({Key? key}) : super(key: key);

  @override
  State<AddingTaskPage> createState() => _AddingTaskPageState();
}

class _AddingTaskPageState extends State<AddingTaskPage> {

  late final LocalNotificationService service;
  final _formKey = GlobalKey<FormState>();
  final dataProvider = DataProvider.dataProvider;
  final priorityName = {
    'DO FIRST': PriorityTask.doFirst,
    'SCHEDULE': PriorityTask.schedule,
    'DELEGATE': PriorityTask.delegate,
    'DON\'T DO': PriorityTask.doNotDo,
  };

  final _taskNameController = TextEditingController();
  final _taskDescController = TextEditingController();
  var _dateSelected = DateTime.now();
  var _timeSelected = TimeOfDay.now();
  var _priority = 'DO FIRST';


  @override
  void initState() {
    service = LocalNotificationService();
    super.initState();
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _taskDescController.dispose();
    dataProvider.close();
    super.dispose();
  }
  
  String? _validateTaskName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the task's name";
    }
    return null;
  }

  void onPressedScheduleDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateSelected,
      firstDate: DateTime.now(),
      lastDate: DateTime(2023),);
    if (picked != null) {
      setState(() {
        _dateSelected = picked;
      });
    }
  }

  void onPressedScheduleTime() async {
    TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: _timeSelected,
        helpText: 'Schedule time'
    );
    if (picked != null) {
      setState(() {
        _timeSelected = picked;
      });
    }
  }

  void onSelectedPriority(String? value) {
    setState(() {
      if (value != null) {
        _priority = value;
      }
    });
  }

  void createTask() async {
    if (_formKey.currentState!.validate()) {
      final task = await createTaskDb();
      final noti = await createNotificationDb(task);
      if (task.toDoTime.subtract(const Duration(minutes: 10)).isAfter(DateTime.now())) {
        await service.showScheduleNotification(
          id: noti.notificationId!,
          title: noti.title,
          body: noti.description,
          time: noti.time,
          payload: noti.taskId.toString(),
        );
      }
      Navigator.pop(context, true);
    }
  }

  Future<Task> createTaskDb() async {
    var task = Task(
      name: _taskNameController.text,
      description: _taskDescController.text,
      toDo: true,
      toDoTime: DateTime(_dateSelected.year, _dateSelected.month, _dateSelected.day, _timeSelected.hour, _timeSelected.minute),
      priority: priorityName[_priority]!,
    );
    task.taskId = await dataProvider.insertTask(task);
    return task;
  }

  Future<AppNotification> createNotificationDb(Task task) async {
    var noti = AppNotification(
      title: '1 task is coming',
      description: task.name,
      time: task.toDoTime.subtract(const Duration(minutes: 10)),
      taskId: task.taskId!,
    );
    noti.notificationId = await dataProvider.insertNotification(noti);
    return noti;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _TaskNameTextField(validateTaskName: _validateTaskName, controller: _taskNameController,),
                _DescriptionTextField(controller: _taskDescController,),
                _ScheduleDate(dateSelected: _dateSelected, onPressed: onPressedScheduleDate,),
                _ScheduleTime(timeSelected: _timeSelected, onPressed: onPressedScheduleTime),
                _SelectedPriority(onChanged: onSelectedPriority, priority: _priority,),
                const SizedBox(height: 16,),
                _CreateButton(notificationService: service, formKey: _formKey, onPressed: createTask,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TaskNameTextField extends StatelessWidget {
  const _TaskNameTextField({Key? key, required this.validateTaskName, required this.controller}) : super(key: key);

  final String? Function(String?) validateTaskName;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.penFancy, size: 12,),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validateTaskName,
            decoration: InputDecoration(
              hintText: 'Task name',
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintStyle: context.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: context.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}


class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField({Key? key, required this.controller,}) : super(key: key);
  
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.alignLeft, size: 12,),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Description',
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
            maxLines: null,
            style: context.bodyLarge,
          ),
        ),
      ],
    );
  }
}

class _ScheduleDate extends StatelessWidget {
  const _ScheduleDate({Key? key, required this.dateSelected, required this.onPressed}) : super(key: key);

  final DateTime dateSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.calendar, size: 12,),
        Expanded(
          child: TextFormField(
            onTap: onPressed,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: (DateFormat('d MMM yyyy').format(dateSelected)),
              hintStyle: context.bodyLarge,
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}

class _ScheduleTime extends StatelessWidget {
  const _ScheduleTime({Key? key, required this.timeSelected, required this.onPressed}) : super(key: key);

  final TimeOfDay timeSelected;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.clock, size: 12,),
        Expanded(
          child: TextFormField(
            onTap: onPressed,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: '${timeSelected.hour}:${timeSelected.minute}',
              hintStyle: context.bodyLarge,
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}

class _SelectedPriority extends StatelessWidget {
  const _SelectedPriority({Key? key, required this.onChanged, required this.priority}) : super(key: key);

  final String priority;
  final void Function(String?) onChanged;
  static const priorities = [
    'DO FIRST',
    'SCHEDULE',
    'DELEGATE',
    'DON\'T DO',
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.flag, size: 12,),
        const SizedBox(width: 8,),
        Expanded(
          child: DropdownButton<String>(
            style: context.bodyMedium,
            isExpanded: true,
            value: priority,
            items: priorities.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value),);
            }).toList(),
            onChanged: onChanged,
          ),
        )
      ],
    );
  }
}



class _CreateButton extends StatelessWidget {
  const _CreateButton({Key? key, required this.notificationService, required this.formKey, required this.onPressed}) : super(key: key);

  final LocalNotificationService notificationService;
  final GlobalKey<FormState> formKey;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(context.bodyMedium),
              backgroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.primary,),
              foregroundColor: MaterialStateProperty.all(AppTheme.lightTheme(null).colorScheme.onPrimary,),
            ),
            child: const Text('Create Task')
          ),
        ),
      ],
    );
  }
}
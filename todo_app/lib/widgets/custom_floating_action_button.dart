import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/service/local_notice_service.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key, required this.notificationService, required this.formKey}) : super(key: key);

  final LocalNotificationService notificationService;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, right: 16, bottom: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter the task's name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Task name',
                          border: const UnderlineInputBorder(
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
                      TextField(
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          isCollapsed: true,
                        ),
                        maxLines: null,
                        style: context.bodyLarge,
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const ScheduleDate(),
                          const SizedBox(width: 16,),
                          const ScheduleTime(),
                          const SizedBox(width: 16,),
                          OutlinedButton(
                            onPressed: () {
                              // TODO: dialog to choose project
                            },
                            //child: Text(_projectSelected),
                            child: const Text('Priority'),
                          ),
                          const Spacer(),
                          CreateButton(notificationService: notificationService, formKey: formKey,),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(48),
      ),
      child: const Icon(Icons.add_rounded),
    );
  }
}

class ScheduleDate extends StatefulWidget {
  const ScheduleDate({Key? key}) : super(key: key);

  @override
  State<ScheduleDate> createState() => _ScheduleDateState();
}

class _ScheduleDateState extends State<ScheduleDate> {

  var _dateSelected = DateTime.now();

  void onPress() async {
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

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Text(DateFormat('d MMM yyyy').format(_dateSelected)),
    );
  }
}

class ScheduleTime extends StatefulWidget {
  const ScheduleTime({Key? key}) : super(key: key);

  @override
  State<ScheduleTime> createState() => _ScheduleTimeState();
}

class _ScheduleTimeState extends State<ScheduleTime> {

  var _timeSelected = TimeOfDay.now();

  void onPress() async {
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

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPress,
      child: Text('${_timeSelected.hour}:${_timeSelected.minute}'),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({Key? key, required this.notificationService, required this.formKey}) : super(key: key);

  final LocalNotificationService notificationService;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          Navigator.pop(context);
          /*await notificationService.showScheduleNotification(
            id: 0,
            title: 'Notification Schedule title',
            body: 'Some content',
            seconds: 5,
            payload: '10',
          );*/
        }
      },
      icon: const Icon(Icons.send_rounded),
      color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
    );
  }
}


import 'package:flutter/material.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/routes/home/notifications_page.dart';
import 'package:todo_app/routes/home/tasks_page.dart';
import 'package:todo_app/service/local_notice_service.dart';
import 'package:todo_app/widgets/custom_app_bar.dart';
import 'package:todo_app/widgets/custom_bottom_nav_bar.dart';
import 'package:todo_app/widgets/loading_circle.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final DataProvider dataProvider = DataProvider.dataProvider;
  Future<List<Task>>? _dataFuture;
  var allTasks = <Task>[];
  var currentIndex = 0;
  late final LocalNotificationService service;
  final screenTitles = ['Tasks', 'Notifications'];

  @override
  void initState() {
    _dataFuture = getDatabase();
    service = LocalNotificationService();
    super.initState();
  }

  @override
  void dispose() {
    dataProvider.close();
    super.dispose();
  }

  Future<List<Task>> getDatabase() async {
    return await dataProvider.getAllTasks();
  }

  void onTapCallback(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  Future<void> onDoneTaskCallback(int id) async {
    await dataProvider.deleteTask(id);
    int? notificationId = await dataProvider.getNotifications(id);
    if (notificationId != null) {
      await service.cancelNotification(id: notificationId);
    }
    onUpdateTaskCallback();
  }

  Future<void> onUpdateTaskCallback() async {
    _dataFuture = getDatabase();
    setState(() {});
  }

  Future<void> onDeleteTaskCallback(int? taskId) async {
    if (taskId != null) {
      await dataProvider.deleteTask(taskId);
      int? notificationId = await dataProvider.getNotifications(taskId);
      if (notificationId != null) {
        await service.cancelNotification(id: notificationId);
        await dataProvider.deleteNotification(notificationId);
      }
      onUpdateTaskCallback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingCircle();
        }

        if (snapshot.hasData) {
          allTasks = snapshot.data;
          allTasks.sort((a, b) => a.toDoTime.compareTo(b.toDoTime));
          final screens = [
            TasksPage(
              allTasks: allTasks,
              onDoneTaskCallback: onDoneTaskCallback,
              onUpdateTaskCallback: onUpdateTaskCallback,
              onDeleteTaskCallback: onDeleteTaskCallback
            ),
            const NotificationsPage(),
          ];
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(title: screenTitles[currentIndex], allTasks: allTasks,),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  await Navigator.pushNamed(context, RouteGenerator.addingTaskPage);
                  onUpdateTaskCallback();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(48),
                ),
                child: const Icon(Icons.add_rounded),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: CustomBottomNavigationBar(
                currentIndex: currentIndex,
                onTap: onTapCallback,
              ),
              body: screens[currentIndex],
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

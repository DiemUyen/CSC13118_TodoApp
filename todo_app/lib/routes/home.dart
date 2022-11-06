import 'package:flutter/material.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/routes/home/notifications_page.dart';
import 'package:todo_app/routes/home/tasks_page.dart';
import 'package:todo_app/widgets/custom_bottom_nav_bar.dart';

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

  @override
  void initState() {
    _dataFuture = getDatabase();
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
          allTasks = snapshot.data;
          allTasks.sort((a, b) => a.toDoTime.compareTo(b.toDoTime));
          final screens = [TasksPage(allTasks: allTasks), NotificationsPage(allTasks: allTasks,)];
          return SafeArea(
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  var result = await Navigator.pushNamed(context, RouteGenerator.addingTaskPage);
                  setState(() {
                    _dataFuture = getDatabase();
                  });
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

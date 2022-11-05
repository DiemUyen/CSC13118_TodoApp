import 'package:flutter/material.dart';
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

  var currentIndex = 0;
  final screens = [const TasksPage(), const NotificationsPage()];
  void onTapCallback(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.addingTaskPage);
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
}

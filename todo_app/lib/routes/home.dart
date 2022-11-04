import 'package:flutter/material.dart';
import 'package:todo_app/routes/home/personal_page.dart';
import 'package:todo_app/routes/home/tasks_page.dart';
import 'package:todo_app/service/local_notice_service.dart';
import 'package:todo_app/widgets/custom_bottom_nav_bar.dart';
import 'package:todo_app/widgets/custom_floating_action_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var currentIndex = 0;
  final screens = [const TasksPage(), const PersonalPage()];
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    super.initState();
  }

  void onTapCallback(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: CustomFloatingActionButton(notificationService: service,),
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

import 'package:flutter/material.dart';
import 'package:todo_app/routes/detail/detail_task_page.dart';
import 'package:todo_app/routes/home.dart';
import 'package:todo_app/routes/home/adding_task_page.dart';

class RouteGenerator {

  static const String homePage = '/home';

  // Tasks
  static const String detailTaskPage = '/detailTask';
  static const String addingTaskPage = '/addingTask';

  // Private constructor
  RouteGenerator._();

  // Generate route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage()
        );
      case detailTaskPage:
        return MaterialPageRoute(
          builder: (_) => DetailTaskPage(taskId: settings.arguments as String,)
        );
      case addingTaskPage:
        return MaterialPageRoute(
          builder: (_) => const AddingTaskPage()
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage()
        );
    }
  }
}
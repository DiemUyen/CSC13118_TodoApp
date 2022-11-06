import 'package:flutter/material.dart';
import 'package:todo_app/routes/detail/detail_task_page.dart';
import 'package:todo_app/routes/detail/editing_task_page.dart';
import 'package:todo_app/routes/detail/notifications_setting_page.dart';
import 'package:todo_app/routes/detail/profile_page.dart';
import 'package:todo_app/routes/home.dart';
import 'package:todo_app/routes/home/adding_task_page.dart';
import 'package:todo_app/routes/home/personal_page.dart';

class RouteGenerator {

  static const String homePage = '/home';

  // Tasks
  static const String detailTaskPage = '/detailTask';
  static const String addingTaskPage = '/addingTask';
  static const String editingTaskPage = '/editingTask';

  // Personal
  static const String personalPage = '/personal';
  static const String profilePage = '/profile';
  static const String notificationsSettingPage = '/notificationsSetting';

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
      case personalPage:
        return MaterialPageRoute(
          builder: (_) => const PersonalPage()
        );
      case profilePage:
        return MaterialPageRoute(
          builder: (_) => const ProfilePage()
        );
      case notificationsSettingPage:
        return MaterialPageRoute(
          builder: (_) => const NotificationsSettingPage()
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomePage()
        );
    }
  }
}
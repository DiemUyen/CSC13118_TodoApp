import 'package:flutter/material.dart';
import 'package:todo_app/routes/detail/detail_task_page.dart';
import 'package:todo_app/routes/detail/notifications_setting_page.dart';
import 'package:todo_app/routes/detail/profile_page.dart';
import 'package:todo_app/routes/home/notifications_page.dart';
import 'package:todo_app/routes/home/personal_page.dart';
import 'package:todo_app/routes/home/tasks_page.dart';

class RouteGenerator {
  // Tasks
  static const String tasksPage = '/tasks';
  static const String detailTaskPage = '/detailTask';

  // Personal
  static const String personalPage = '/personal';
  static const String profilePage = '/profile';
  static const String notificationsSettingPage = '/notificationsSetting';

  // Notification
  static const String notificationsPage = '/notifications';

  // Private constructor
  RouteGenerator._();

  // Generate route
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case tasksPage:
        return MaterialPageRoute(
          builder: (_) => const TasksPage()
        );
      case detailTaskPage:
        return MaterialPageRoute(
          builder: (_) => const DetailTaskPage()
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
      case notificationsPage:
        return MaterialPageRoute(
          builder: (_) => const NotificationsPage()
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const TasksPage()
        );
    }
  }
}
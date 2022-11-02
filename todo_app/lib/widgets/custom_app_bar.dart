import 'package:flutter/material.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.headlineMedium,
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.searchPage);
          },
          icon: const Icon(Icons.search_rounded),
          color: AppTheme.lightTheme(null).colorScheme.primary,
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.notificationsPage);
          },
          icon: const Icon(Icons.notifications_rounded),
          color: AppTheme.lightTheme(null).colorScheme.primary,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height,);
}

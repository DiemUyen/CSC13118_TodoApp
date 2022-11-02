import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.bold
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.searchPage);
          },
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          color: AppTheme.lightTheme(null).colorScheme.primary,
        ),
        const SizedBox(width: 8,),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteGenerator.notificationsPage);
          },
          icon: const FaIcon(FontAwesomeIcons.solidBell),
          color: AppTheme.lightTheme(null).colorScheme.primary,
        ),
        const SizedBox(width: 8,),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height,);
}

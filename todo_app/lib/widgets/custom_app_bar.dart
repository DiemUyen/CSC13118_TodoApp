import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:todo_app/widgets/data_search_delegate.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({Key? key, required this.title, required this.allTasks}) : super(key: key);

  final String title;
  final List<Task> allTasks;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: context.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: AppTheme.lightTheme(null).colorScheme.onSurface
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(context: context, delegate: DataSearchDelegate(allTasks),);
          },
          icon: const FaIcon(FontAwesomeIcons.magnifyingGlass),
          color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 8,),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height,);
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/routes.dart';
import 'package:todo_app/utils/app_theme.dart';

class DataSearchDelegate extends SearchDelegate {

  final List<Task> searchResults;

  DataSearchDelegate(this.searchResults);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const FaIcon(FontAwesomeIcons.xmark),
        color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const FaIcon(FontAwesomeIcons.angleLeft),
      color: AppTheme.lightTheme(null).colorScheme.onSurfaceVariant,
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppTheme.lightTheme(null).colorScheme.onSurface
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Task> suggestions = query.isEmpty
        ? []
        : searchResults.where((element) => element.name.toLowerCase().contains(query.toLowerCase())).toList();

    if (suggestions.isNotEmpty) {
      return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return ListTile(
            title: Text(
              suggestion.name,
            ),
            onTap: () {
              query = suggestion.name;
              Navigator.pushNamed(context, RouteGenerator.detailTaskPage, arguments: suggestion.taskId.toString());
            },
          );
        },
      );
    }
    
    return Center(
      child: Text(
        'No task found',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
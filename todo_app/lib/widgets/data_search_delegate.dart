import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';

class DataSearchDelegate extends SearchDelegate {

  // TODO: Change to all tasks and projects
  List<String> searchResults = [
    'Design Mobile UI',
    'Write test script for SoapUI',
    'Do homework Math',
    'Review unit 4 HSK 1',
    'Group tasking',
  ];

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
        style: context.bodyMedium?.copyWith(
            color: AppTheme.lightTheme(null).colorScheme.onSurface
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? []
        : searchResults.where((element) => element.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(
            suggestion,
            style: context.bodyMedium,
          ),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    var superThemeData = super.appBarTheme(context);
    return superThemeData.copyWith(
      textTheme: superThemeData.textTheme.copyWith(
        headline6: context.bodyMedium
      )
    );
  }

}
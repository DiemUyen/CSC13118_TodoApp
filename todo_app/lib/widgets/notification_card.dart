import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/models/notification.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:todo_app/utils/extensions.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationCard extends StatelessWidget {
  const NotificationCard({Key? key, required this.noti}) : super(key: key);

  final AppNotification noti;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to task with id is payload
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FaIcon(FontAwesomeIcons.bell),
              const SizedBox(width: 16,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noti.title,
                    style: context.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    noti.description,
                    style: context.bodyMedium,
                  ),
                ],
              ),
              const Spacer(),
              Text(
                timeago.format(noti.time),
                style: context.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme(null).colorScheme.tertiary,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


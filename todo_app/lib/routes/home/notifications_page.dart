import 'package:flutter/material.dart';
import 'package:todo_app/models/notification.dart';
import 'package:todo_app/widgets/custom_app_bar.dart';
import 'package:todo_app/widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  var notifications = <AppNotification>[
    AppNotification(notificationId: 1, title: 'title', description: 'description', time: DateTime(2022, 11, 4, 23, 15), payload: 'payload',),
    AppNotification(notificationId: 2, title: 'title 2', description: 'description 2', time: DateTime(2022, 11, 4, 20, 30), payload: 'payload 2',),
    AppNotification(notificationId: 3, title: 'title 3', description: 'description 3', time: DateTime(2022, 11, 4, 12, 15), payload: 'payload 3',),
    AppNotification(notificationId: 4, title: 'title 4', description: 'description 4', time: DateTime(2022, 11, 2, 10, 00), payload: 'payload 4',),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Notification',),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(noti: notifications[index],);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:todo_app/data_access/data_provider.dart';
import 'package:todo_app/models/notification.dart';
import 'package:todo_app/widgets/loading_circle.dart';
import 'package:todo_app/widgets/notification_card.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key,}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  final _dataProvider = DataProvider.dataProvider;
  Future<List<AppNotification>>? _dataFuture;
  var allNotifications = <AppNotification>[];
  var sentNotification = <AppNotification>[];

  @override
  void initState() {
    _dataFuture = getNotifications();
    super.initState();
  }

  Future<List<AppNotification>> getNotifications() async {
    return await _dataProvider.getAllNotifications();
  }

  @override
  void dispose() {
    _dataProvider.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingCircle();
        }

        if (snapshot.hasData) {
          allNotifications = snapshot.data;
          sentNotification =
              allNotifications.where((element) => element.time.isBefore(DateTime.now())).toList();
          sentNotification.sort((a, b) => b.time.compareTo(a.time));
          return Scaffold(
            //appBar: CustomAppBar(title: 'Notification', allTasks: widget.allTasks,),
            body: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: sentNotification.length,
              itemBuilder: (context, index) {
                return NotificationCard(noti: sentNotification[index],);
              },
            ),
          );
        }

        return SafeArea(
          child: Scaffold(
            body: Container(),
          ),
        );
      },
    );
  }
}

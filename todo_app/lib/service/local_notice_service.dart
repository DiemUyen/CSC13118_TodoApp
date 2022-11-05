import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:todo_app/main.dart';
import 'package:todo_app/routes.dart';

class LocalNotificationService {
  final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
  //final onNotificationClick = BehaviorSubject();

  // Singleton
  static LocalNotificationService? _localNotificationService;
  LocalNotificationService._createInstance();
  factory LocalNotificationService() {
    if (_localNotificationService == null) {
      _localNotificationService = LocalNotificationService._createInstance();
      _localNotificationService!._initialize();
    }
    return _localNotificationService!;
  }

  // Initialize
  void _onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      debugPrint('Notification payload: $payload');
      Navigator.pushNamed(MyApp.navigatorKey.currentContext!, RouteGenerator.detailTaskPage);
    }
  }

  void _onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) async {
    Navigator.pushNamed(MyApp.navigatorKey.currentContext!, RouteGenerator.detailTaskPage);
  }

  Future<void> _initialize() async {
    tz_data.initializeTimeZones();
    const androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iosSetting = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final initSettings = InitializationSettings(android: androidSetting, iOS: iosSetting);
    await _localNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse,
    );
  }

  // Notification details
  Future<NotificationDetails> _notificationDetails() async {
    const androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const iosNotificationDetails = DarwinNotificationDetails();
    return const NotificationDetails(android: androidNotificationDetails, iOS: iosNotificationDetails);
  }

  // Show notifications
  Future<void> showNotification({
    required int id,
    required String title,
    required String body
  }) async {
    final notificationDetails = await _notificationDetails();
    await _localNotificationsPlugin.show(id, title, body, notificationDetails);
  }

  Future<void> showScheduleNotification({
    required int id,
    required String title,
    required String body,
    required int seconds,
    required String payload,
  }) async {
    final notificationDetails = await _notificationDetails();
    await _localNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(DateTime.now().add(Duration(seconds: seconds)), tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  //final pendingNotificationRequests = await _localNotificationsPlugin.pendingNotificationRequests();

}
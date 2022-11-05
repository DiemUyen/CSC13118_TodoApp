import 'package:flutter/material.dart';

class AppNotification {
  final int notificationId;
  final String title;
  final String description;
  final DateTime time;
  final String payload;

  const AppNotification({
    required this.notificationId,
    required this.title,
    required this.description,
    required this.time,
    required this.payload,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
      'payload': payload
    };
  }
  
  factory AppNotification.fromMap(Map<String, dynamic> noti) {
    return AppNotification(
      notificationId: noti['notificationId'],
      title: noti['title'],
      description: noti['description'],
      time: DateTime.parse(noti['time']),
      payload: noti['payload'],
    );
  }  
}
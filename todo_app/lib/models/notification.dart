class AppNotification {
  int? notificationId;
  final String title;
  final String description;
  final DateTime time;
  final int taskId;

  AppNotification({
    this.notificationId,
    required this.title,
    required this.description,
    required this.time,
    required this.taskId,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'notificationId': notificationId,
      'title': title,
      'description': description,
      'time': time.toIso8601String(),
      'taskId': taskId
    };
  }
  
  factory AppNotification.fromMap(Map<String, dynamic> noti) {
    return AppNotification(
      notificationId: noti['notificationId'],
      title: noti['title'],
      description: noti['description'],
      time: DateTime.parse(noti['time']),
      taskId: noti['taskId'],
    );
  }  
}
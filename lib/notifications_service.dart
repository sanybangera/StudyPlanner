import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings
        androidInitializationSettings =
        AndroidInitializationSettings(
            '@mipmap/ic_launcher');

    const InitializationSettings
        initializationSettings =
        InitializationSettings(
      android:
          androidInitializationSettings,
    );

    await flutterLocalNotificationsPlugin
        .initialize(
            initializationSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails
        androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'study_channel',
      'Study Notifications',
      channelDescription:
          'Study Planner Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails
        platformChannelSpecifics =
        NotificationDetails(
      android:
          androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin
        .show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
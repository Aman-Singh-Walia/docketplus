import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init() async {
    const android = AndroidInitializationSettings('ic_notification');
    const ios = IOSInitializationSettings();
    const initializationSettings =
        InitializationSettings(android: android, iOS: ios);
    await _notifications.initialize(initializationSettings);
    tz.initializeTimeZones();
    final locationName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(locationName));
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
          id,
          title,
          body,
          const NotificationDetails(
              android: AndroidNotificationDetails('channelId', 'channelName',
                  importance: Importance.max, icon: 'ic_notification'),
              iOS: IOSNotificationDetails()),
          payload: payload);

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduleDate, tz.local),
          const NotificationDetails(
              android: AndroidNotificationDetails('channelId', 'channelName',
                  importance: Importance.max, icon: 'ic_notification'),
              iOS: IOSNotificationDetails()),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          androidAllowWhileIdle: true);

  static Future removeSchedules(int notificationId) =>
      _notifications.cancel(notificationId);
}// notofication api

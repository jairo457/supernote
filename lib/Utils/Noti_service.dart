import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('b2_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max, priority: Priority.high),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int? id, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id!, title, body, await notificationDetails());
  }

  Future PeriodicallyNotificationDaily(
      {int? id, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.periodicallyShow(
        id!, title, body, RepeatInterval.daily, await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future PeriodicallyNotificationHour(
      {int? id, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.periodicallyShow(
        id!, title, body, RepeatInterval.hourly, await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future PeriodicallyNotificationMinute(
      {int? id, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.periodicallyShow(id!, title, body,
        RepeatInterval.everyMinute, await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future PeriodicallyNotificationWeek(
      {int? id, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.periodicallyShow(
        id!, title, body, RepeatInterval.weekly, await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle);
  }

  Future scheduleNotification(
      {int? id,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id!,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        //androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        // ignore: deprecated_member_use
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future cancel(int id) {
    return notificationsPlugin.cancel(id);
  }
}

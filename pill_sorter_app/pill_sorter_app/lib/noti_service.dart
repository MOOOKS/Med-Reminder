import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import "package:timezone/timezone.dart" as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  // INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return; // prevent re-initialization

    tz.initializeTimeZones();
    final String currentTimeZone = 'America/Los_Angeles';
    tz.setLocalLocation(tz.getLocation(currentTimeZone));


    // prepare android init settings
    const initSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // prepare ios init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "daily_channel_id",
        "Daily Notifications",
        channelDescription: "Daily Notification Channel",
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }


  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    if (!_isInitialized) {
      await initNotification(); // ✅ Ensure notifications are initialized
    }
    debugPrint("pop out and show");
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    required String title,
    required String body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    debugPrint("set current date");
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    // Schedule the notification
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),

      // iOS specific: Use exact time specified (vs relative time)
      // uiLocalNotificationDateInterpretation:
      //  UILocalNotificationDateInterpretation.absoluteTime,

      // Android specific: Allow notification while device is in low-power mode
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      // Make notification repeat DAILY at same time
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint("Notification Scheduled");
  }

  Future<void> periodicallyScheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime startDate,
    required String? frequency,
    required List<int>? hours,
    int minute = 0,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var startDateTz = tz.TZDateTime.from(startDate, tz.local);

    if (startDateTz.isBefore(now)) {
      startDateTz = tz.TZDateTime(
          tz.local, now.year, now.month, now.day, hours![0], minute);
    }


    debugPrint("set periodically");

    for (int i = 0; i < hours!.length; i++) {
      tz.TZDateTime scheduledTime = tz.TZDateTime(
          tz.local,
          startDateTz.year,
          startDateTz.month,
          startDateTz.day,
          hours[i],
          minute
      );
      int uniqueId = id * 100 + hours[i];
      debugPrint("the id is ${id.toString()}");
      DateTimeComponents? matchComponents = _getMatchDateTimeComponents(
          frequency!);

      // Schedule the notification
      await notificationsPlugin.zonedSchedule(
        uniqueId,
        title,
        body,
        scheduledTime,
        notificationDetails(),

        // iOS specific: Use exact time specified (vs relative time)
        // uiLocalNotificationDateInterpretation:
        //  UILocalNotificationDateInterpretation.absoluteTime,

        // Android specific: Allow notification while device is in low-power mode
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

        // Make notification repeat DAILY at same time
        matchDateTimeComponents: matchComponents,
      );
      debugPrint("Notification Scheduled $uniqueId $scheduledTime $matchComponents");
    }
  }

  // Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
    debugPrint("all medications cancelled");
  }

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
    debugPrint("cancelled medication id: $id");
  }

  Future<void> cancelAllPendingNotificationIDsOfBase(int baseId) async{
    List<PendingNotificationRequest> activeNotifications = await notificationsPlugin.pendingNotificationRequests();
    debugPrint("all notifications $activeNotifications");
    for(int i = 0; i < activeNotifications.length; i++){
      if(activeNotifications[i].id!~/100 == baseId){
        await cancelNotification(activeNotifications[i].id);
        debugPrint("notification ${activeNotifications[i].id} was cancelled");
      }
    }

  }

  DateTimeComponents? _getMatchDateTimeComponents(String frequency) {
    switch (frequency.toLowerCase()) {
      case "daily":
        return DateTimeComponents.time; // Fires at the same time every day
      case "weekly":
        return DateTimeComponents
            .dayOfWeekAndTime; // Fires at the same time every week
      case "monthly":
        return DateTimeComponents
            .dayOfMonthAndTime; // Fires at the same time every month
      case "yearly":
        return DateTimeComponents
            .dateAndTime; // Fires at the same time every year
      default:
        return DateTimeComponents.time;
    }
  }
}
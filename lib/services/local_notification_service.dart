import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();
  
  
  Future<void> initialize() async {

    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitializationSettings = 
        AndroidInitializationSettings('@drawable/ic_stat_alarm');

    DarwinInitializationSettings iosInitializationSettings =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings,);
    
    await _localNotificationService.initialize(settings, onDidReceiveNotificationResponse: onDidReceiveNotificationResponse, );
  }

  Future<NotificationDetails> _notificationDetails() async{
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        'channelId',
        'channelName',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true
    );

    const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails();


    return const NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails
    );
  }
  
  Future<void> showNotification({required int id, required String title, required String body}) async{
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  Future<void> showScheduledNotification({required int id, required String title, required String body, required DateTime dateTime}) async{
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
        id,
        title, 
        body,
        tz.TZDateTime.from(dateTime, tz.local,),
        details,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }


  void onDidReceiveLocalNotification(int id, String? title, String? body, String? payload) {
    print('id $id');
  }

  void onDidReceiveNotificationResponse(NotificationResponse? response){
    String? p = response?.payload.toString();
    print('payload $p');
  }
}
import 'package:flutter/material.dart';
import 'package:labs/services/local_notification_service.dart';

class Kolokvium extends StatelessWidget{
  String name;
  DateTime dateTime;
  DateTime until;
  late final LocalNotificationService service;
  

  Kolokvium(this.name, this.dateTime, this.until) {
    this.name = name;
    this.dateTime = dateTime;
    this.until = until;
    service = LocalNotificationService();
    service.initialize();
    service.showScheduledNotification(id: 0, title: name, body: 'You have exam for $name in 1 hour', dateTime: dateTime.subtract(const Duration(hours: 1)));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            ),
            Text(
                '${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}  -  ${dateTime.day.toString().padLeft(2,'0')}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.year}',
              style: const TextStyle(
                color: Colors.grey
              ),
            )
          ],
        ),
      ),
    );
  }

}
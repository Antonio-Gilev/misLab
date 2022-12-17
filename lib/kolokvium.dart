import 'package:flutter/material.dart';
import 'package:labs/services/local_notification_service.dart';
import 'package:labs/widgets/maps.dart';

enum Places{
  TMF,
  FEIT,
  BARAKA1,
  BARAKA2
}


class Kolokvium extends StatelessWidget{
  String name;
  DateTime dateTime;
  DateTime until;
  late final LocalNotificationService service;
  Places place;
  late String lat;
  late String lon;
  

  Kolokvium(this.name, this.dateTime, this.until, this.place) {
    this.name = name;
    this.dateTime = dateTime;
    this.until = until;
    service = LocalNotificationService();
    service.initialize();
    service.showScheduledNotification(id: 0, title: name, body: 'You have exam for $name in 1 hour', dateTime: dateTime.subtract(const Duration(hours: 1)));

    if(this.place == Places.BARAKA1){
      lat = '42.00477959708281';
      lon= '21.406590178780345';
    }else if(this.place == Places.BARAKA2){
      lat = '42.00461784549463';
      lon= '21.406554514631182';
    }
    else if(this.place == Places.FEIT){
      lat = '42.004893622905136';
      lon= '21.408167682421695';
    }
    else {
      lat = '42.00472011015235';
      lon= '21.40997201657404';
    }
  }

  void _showMaps(BuildContext ct){
    showModalBottomSheet(
        context: ct,
        isScrollControlled: true,
        builder: (ct){
          return GestureDetector(
            onTap: () {Navigator.pop(ct);},
            behavior: HitTestBehavior.opaque,
            child: Maps(name, lat, lon, place),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListTile(
            leading: const Icon(Icons.school),
            title: Center(
              child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            ),
            subtitle: Column(
              children: [
                Text(
                  '${dateTime.hour.toString().padLeft(2,'0')}:${dateTime.minute.toString().padLeft(2,'0')}  -  ${dateTime.day.toString().padLeft(2,'0')}-${dateTime.month.toString().padLeft(2,'0')}-${dateTime.year}',

                ),
                Text(
                  place.name,

                ),
              ],
            ),
            trailing: FloatingActionButton(
              onPressed: () => _showMaps(context),
              backgroundColor: Colors.blue,
              child: Icon(Icons.gps_fixed),
            ),
          ),
        ),
      )
    );
  }

}
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:labs/services/local_notification_service.dart';
import 'package:labs/widgets/maps.dart';
import 'package:labs/widgets/nov_element.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'auth/login.dart';
import 'classes/termini.dart';
import 'kolokvium.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Code Land",
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white70)
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late SharedPreferences sharedPreferences;
  late final LocalNotificationService service;

  List<Kolokvium> kolList = [
    Kolokvium("name", DateTime.now(), DateTime.now().add(const Duration(minutes: 90)), Places.FEIT),
    Kolokvium("name2", DateTime.now(), DateTime.now().add(const Duration(minutes: 90)), Places.TMF)
  ];

  void _addItemFunction(BuildContext ct){
    showModalBottomSheet(
        context: ct,
        isScrollControlled: true,
        builder: (ct){
      return GestureDetector(
        onTap: () {Navigator.pop(context);},
        behavior: HitTestBehavior.opaque,
        child: NovElement(_addNewItemToList),
      );
    });
  }

  void _addNewItemToList(Kolokvium kolokvium){
    setState(() {
      kolList.add(kolokvium);
    });
  }

  void _showMaps(BuildContext ct){
    showModalBottomSheet(
        context: ct,
        isScrollControlled: true,
        builder: (ct){
          return GestureDetector(
            onTap: () {Navigator.pop(ct);},
            behavior: HitTestBehavior.opaque,
            child: Maps(kolList),
          );
        });
  }


  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    service = LocalNotificationService();
    service.initialize();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text("191102", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
              onPressed: () => _addItemFunction(context),
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () => _showMaps(context),
              icon: const Icon(Icons.map)),
          IconButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => const LoginPage()), (Route<dynamic> route) => false);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Colors.blue],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: [
            ...kolList
          ],
        ),
      ),
      drawer: Drawer(
        child: SfCalendar(
          view: CalendarView.schedule,
          timeSlotViewSettings: const TimeSlotViewSettings(
              startHour: 8,
              endHour: 19
          ),
          dataSource: Termini(kolList),
          monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await service.showNotification(id: 0, title: 'Notification Title', body: 'Notification Body');
        },
        child: const Icon(Icons.notifications_on),
      ),
    );
  }
}
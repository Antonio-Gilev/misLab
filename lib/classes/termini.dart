
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../kolokvium.dart';

class Termini extends CalendarDataSource {

  Termini(List<Kolokvium> kolokviumi){
    appointments = kolokviumi;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].dateTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].until;
  }

  @override
  String getSubject(int index) {
    return appointments![index].name;
  }

  @override
  Color getColor(int index) {
    return Colors.blue;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }

}
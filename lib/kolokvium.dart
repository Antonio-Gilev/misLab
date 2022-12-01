import 'package:flutter/material.dart';

class Kolokvium extends StatelessWidget{
  String name;
  DateTime dateTime;

  Kolokvium(this.name, this.dateTime);

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
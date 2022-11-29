import 'package:flutter/material.dart';

class PizzaAnswer extends StatelessWidget{
  String answerText;
  void Function() tapped;

  PizzaAnswer(this.answerText, this.tapped);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
            onPressed: tapped,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text(
              answerText,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            )));
  }
}
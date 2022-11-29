import 'package:flutter/material.dart';

class PizzaQuestion extends StatelessWidget{

  var questionContent;

  PizzaQuestion(this.questionContent);



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      child: Text(
        questionContent,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),
      ),
    );


  }


}
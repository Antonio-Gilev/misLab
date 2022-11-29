import 'package:flutter/material.dart';
import 'package:labs/pizza_answer.dart';
import './pizza_question.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  State<StatefulWidget> createState(){
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  void _iWasTapped() {
    setState(() {
      _questionIndex += 1;
    });
    print('I Was Tapped');
  }

  var questions = [
    {'question' : 'Choose pants',
    'answer': ['Jeans', 'Trousers', 'Shorts',]},

    {'question' : 'Choose Shirt',
      'answer': ['T-Shirt', 'Classic Shirt', 'Hawaiian Shirt',]},

    {'question' : 'Select Accessories',
      'answer': ['Glasses', 'Hat', 'Watch', 'All of the above']},
  ];
  var _questionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello World',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('191102'),
        ),
        body: Column(
          children: [
            PizzaQuestion(questions[_questionIndex]['question']),
            ...(questions[_questionIndex]['answer'] as List<String>).map((answer) {
              return PizzaAnswer(answer, _iWasTapped);
            }),
          ],
        ),
      )
    );
  }
}

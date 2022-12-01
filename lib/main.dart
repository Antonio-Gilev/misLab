import 'package:flutter/material.dart';
import 'package:labs/kolokvium.dart';
import 'package:labs/widgets/nov_element.dart';

void main() {
  runApp(( const MaterialApp(home: MyApp() ,)));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<StatefulWidget> createState(){
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {

  List<Kolokvium> kolList = [
    Kolokvium("name", DateTime.now()),
    Kolokvium("name2", DateTime.now())
  ];

  void _addItemFunction(BuildContext ct){
    showModalBottomSheet(
        context: ct, builder: (ct){
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


  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Hello World',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('191102'),
          actions: <Widget>[
            IconButton(onPressed: () => _addItemFunction(context), icon: const Icon(Icons.add))
          ],
        ),

        body: Column(
          children: [
            ...kolList
          ],
        ),
      )
    );
  }
}

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:labs/kolokvium.dart';
import 'package:intl/intl.dart';

class NovElement extends StatefulWidget{

  final Function addItem;

  NovElement(this.addItem);


  @override
  State<StatefulWidget> createState() => _NovElementState();

}

class _NovElementState extends State<NovElement>{

  final _nameController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  late String naslov;
  late double vrednost;

  void _submitData(){
    if(selectedDate.toString().isEmpty){
      return;
    }
    final name = _nameController.text;
    if(name.isEmpty ){
      return;
    }

    final newKolokvium = Kolokvium(name, selectedDate);
    widget.addItem(newKolokvium);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-dd HH:mm");
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: "Име на Предмет"),
            onSubmitted: (_) => _submitData(),
          ),
          DateTimeField(
            format: format,
            decoration: const InputDecoration(labelText: "Датум и Време"),
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                setState(() {
                  selectedDate = DateTimeField.combine(date, time);
                });
                return DateTimeField.combine(date, time);
              } else {
                setState(() {
                  selectedDate = currentValue!;
                });
                return currentValue;
              }
            },
          ),
          Container(
            margin: const EdgeInsets.all(15),
            child: FloatingActionButton(onPressed: _submitData, child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

}
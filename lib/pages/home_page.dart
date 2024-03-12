import 'package:flutter/material.dart';
import 'package:habit_tracker/components/HabitTile.dart';
import 'package:habit_tracker/components/my_alert_dialog.dart';
import 'package:habit_tracker/components/my_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todaysHabitList = [
    ["Morning Run", false],
    ["Read Book", false]
  ];

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertBox(
            controller: _newHabitNameController,
            hintText: 'Enter habit name..',
            onSave: saveNewHabit,
            onCancel: cancelDialogBox,
          );
        });
  }

  void saveNewHabit() {
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });

    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void cancelNewHabit() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1],
            onChanged: (value) => checkBoxTapped(value, index),
          );
        },
      ),
    );
  }
}

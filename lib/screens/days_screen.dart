import 'package:flutter/material.dart';

import '../day_item.dart';
import '../dummy.dart';
import '../models/day_model.dart';

import '../helpers/db_helper.dart';
import '../screens/exercises_screen.dart';

class DaysScreen extends StatefulWidget {
  final Function addDay;
  final Function deleteDay;
  const DaysScreen({Key key, this.addDay, this.deleteDay}) : super(key: key);

  @override
  State<DaysScreen> createState() => _DaysScreenState(deleteDay);
}

class _DaysScreenState extends State<DaysScreen> {
  final List<Day> _userDays = DUMMY_DAYS;

  String title;
  String id;
  final Function deleteDay;

  _DaysScreenState(this.deleteDay);

  // void _deleteDay(id) {
  //   setState(() {
  //     daysList.removeAt(id);
  //   });
  // }

  void _addDay(String dayTitle) {
    final newDay = Day(
      title: dayTitle,
      id: dayTitle,
    );
    setState(() {
      _userDays.add(newDay);
      Navigator.of(context).pop();
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   /* userDay.isEmpty
  //       ? daysList.addAll([DUMMY_DAYS])
  //       :*/
  //   daysList.addAll([_userDays]);
  // }

  void selectDay(BuildContext context) {
    Navigator.of(context).pushNamed(
      ExercisesScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
  }

  // String titleDayInput;
  final titleDayController = TextEditingController();
  void _submitData() {
    final enteredDayTitle = titleDayController.text;

    if (enteredDayTitle.isEmpty || enteredDayTitle == null) {
      return;
    }

    widget.addDay(
      enteredDayTitle,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          'Твоя тренировка',
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: _userDays.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Добавьте Дни',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView(
              padding: const EdgeInsets.all(5),
              children: _userDays
                  .map((day) => DayItem(
                        day.id,
                        day.title,
                      ))
                  .toList(),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).secondaryHeaderColor,
      //   elevation: 6,
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return AlertDialog(
      //           title: Text(
      //             'Введите название дня:',
      //             style: Theme.of(context).textTheme.bodyText1,
      //           ),
      //           content: TextField(
      //             // decoration: InputDecoration(labelText: 'title',),
      //             autofocus: true,
      //             cursorColor: Theme.of(context).secondaryHeaderColor,
      //             cursorHeight: 30,
      //             cursorWidth: 10,
      //             // onChanged: (val) {
      //             //   titleDayInput = val;
      //             // },
      //             controller: titleDayController,
      //             onSubmitted: (_) => _submitData(),
      //           ),
      //           actions: [
      //             FlatButton(
      //               onPressed: () => _addDay(titleDayController.text),
      //               child: Text(
      //                 'Добавить',
      //                 style: Theme.of(context).textTheme.bodyText1,
      //               ),
      //             ),
      //           ],
      //         );
      //       },
      //     );
      //   },
      //   // tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

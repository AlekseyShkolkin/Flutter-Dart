import 'package:flutter/material.dart';

import './screens/exercises_screen.dart';
import './dummy.dart';

class DayItem extends StatefulWidget {
  String id;
  String title;

  DayItem(
    this.id,
    this.title,
  );

  @override
  State<DayItem> createState() => _DayItemState();
}

class _DayItemState extends State<DayItem> {
  void selectDay(BuildContext context) {
    Navigator.of(context).pushNamed(
      ExercisesScreen.routeName,
      arguments: {
        'id': widget.id,
        'title': widget.title,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectDay(context),
      // {
      //   // Navigator.pushNamed(context, '/exercise');
      // },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: Card(
        elevation: 7,
        color: Colors.teal,
        child: ListTile(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline1,
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {} /*=> deleteDay()*/,
          ),
        ),
      ),
    );
  }
}

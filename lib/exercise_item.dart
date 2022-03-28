import 'package:flutter/material.dart';

import './dummy.dart';
import './screens/exercise_detail_screen.dart';

class ExerciseItem extends StatefulWidget {
  String id;
  String title;
  double weight;
  int set;
  int repeat;

  ExerciseItem(
    this.id,
    this.title,
    this.weight,
    this.set,
    this.repeat,
  );

  @override
  State<ExerciseItem> createState() => _ExerciseItemState();
}

class _ExerciseItemState extends State<ExerciseItem> {
  // final String imageUrl;
  void selectExercise(BuildContext context) {
    Navigator.of(context).pushNamed(
      ExerciseDetailScreen.routeName,
      arguments: {
        'id': widget.id,
        'title': widget.title,
        'weight': widget.weight,
        'set': widget.set,
        'repeat': widget.repeat,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectExercise(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        color: Colors.teal,
        child: ListTile(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline1,
          ),
          subtitle: Text(
            'Вес: ${widget.weight.toString()}кг Подходы: ${widget.set.toString()} Повторы: ${widget.repeat.toString()}',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.deepOrangeAccent,
            ),
            onPressed: () {} /* => deleteDay(index)*/,
          ),
        ),
      ),
    );
  }
}

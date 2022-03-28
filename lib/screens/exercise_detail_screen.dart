import 'package:flutter/material.dart';

import '../dummy.dart';

class ExerciseDetailScreen extends StatefulWidget {
  static const routeName = '/detail-exercise';

  ExerciseDetailScreen();

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  double _weightSliderValue = 0;
  double _setSliderValue = 0;
  double _repeatSliderValue = 0;

  // int _setSliderValue = exerciseSet;
  // int _repeatSliderValue = exerciseRepeat;

  @override
  Widget build(BuildContext context) {
    var routeArgs =
        ModalRoute.of(context).settings.arguments as Map<dynamic, dynamic>;

    final exerciseId = routeArgs['id'];
    final exerciseTitle = routeArgs['title'];
    var exerciseWeight = routeArgs['weight'];
    var exerciseSet = routeArgs['set'];
    var exerciseRepeat = routeArgs['repeat'];

    final selectedExercise =
        DUMMY_EXERCISES.firstWhere((exercise) => exercise.id == exerciseId
            //     DUMMY_EXERCISES.where(
            //   (exercise) {
            //     return exercise.days.contains(exerciseTitle);
            //   },
            );
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text(
            exerciseTitle,
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Text(
                exerciseTitle,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Card(
              elevation: 7,
              color: Colors.teal,
              child: ListTile(
                title: Text(
                  'Вес ${_weightSliderValue.toStringAsFixed(1)}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Slider(
              value: _weightSliderValue,
              max: 200,
              divisions: 400,
              onChanged: (double value) {
                setState(() {
                  _weightSliderValue = value;
                });
              },
            ),
            Card(
              elevation: 7,
              color: Colors.teal,
              child: ListTile(
                title: Text(
                  'Подходы ${_setSliderValue.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Slider(
              value: _setSliderValue,
              max: 10,
              // divisions: 10,
              onChanged: (double value) {
                setState(() {
                  _setSliderValue = value;
                });
              },
            ),
            Card(
              elevation: 7,
              color: Colors.teal,
              child: ListTile(
                title: Text(
                  'Повторы ${_repeatSliderValue.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
            ),
            Slider(
              value: _repeatSliderValue,
              max: 30,
              onChanged: (double value) {
                setState(() {
                  _repeatSliderValue = value;
                });
              },
            ),
          ],
        ));
  }
}

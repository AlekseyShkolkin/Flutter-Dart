import 'package:flutter/material.dart';

import './screens/exercises_screen.dart';

class NewExercise extends StatefulWidget {
  final Function addExercise;

  const NewExercise(this.addExercise);
  @override
  State<NewExercise> createState() => _NewExerciseState();
}

class _NewExerciseState extends State<NewExercise> {
  final tilteExerciseController = TextEditingController();
  final weightExerciseController = TextEditingController();
  final setExerciseController = TextEditingController();
  final repeatExerciseController = TextEditingController();
  void _submitData() {
    if (tilteExerciseController.text.isEmpty) {
      return;
    }
    final enteredExerciseTitle = tilteExerciseController.text;
    final enteredWeight = double.parse(weightExerciseController.text);
    final enteredSet = int.parse(setExerciseController.text);
    final enteredRepeat = int.parse(repeatExerciseController.text);

    if (enteredExerciseTitle.isEmpty ||
        enteredWeight <= 0 ||
        enteredSet <= 0 ||
        enteredRepeat <= 0) {
      return;
    }
    widget.addExercise(
      enteredExerciseTitle,
      enteredWeight,
      enteredSet,
      enteredRepeat,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Название упражнения'),
                controller: tilteExerciseController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Вес'),
                controller: weightExerciseController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Подходы'),
                controller: setExerciseController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Повторы'),
                controller: repeatExerciseController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              RaisedButton(
                child: const Text('Добавить упражнение'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: () => _submitData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

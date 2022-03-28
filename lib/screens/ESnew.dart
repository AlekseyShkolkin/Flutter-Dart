import 'package:flutter/material.dart';

import '../dummy.dart';
import '../exercise_item.dart';
import '../models/exercise_model.dart';
import '../exercise_item.dart';

class ExercisesScreen extends StatefulWidget {
  static const routeName = '/exercise';

  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  final List<Exercise> _userExercises = DUMMY_EXERCISES;

  String title;
  String id;
  double weight;
  int set;
  int repeat;

  void _addExercise(
    String exerciseTitle,
    // double weightUser,
    // int setUser,
    // int repeatUser,
  ) {
    final newExercise = Exercise(
      title: exerciseTitle,
      id: title,
      // weight: weightUser,
      // set: setUser,
      // repeat: repeatUser,
    );
    setState(() {
      _userExercises.add(newExercise);
      Navigator.of(context).pop();
    });
  }

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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final dayTitle = routeArgs['title'];
    final dayId = routeArgs['id'];
    final dayExercises = DUMMY_EXERCISES.where((exercise) {
      return exercise.days.contains(dayId);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text(
          dayTitle,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
      body: _userExercises.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Добавьте',
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
          : ListView.builder(
              padding: const EdgeInsets.all(5),
              // children: _userExercises
              //     .map((exercise) => ExerciseItem(
              //           exercise.id,
              //           exercise.title,
              //           exercise.weight,
              //           exercise.set,
              //           exercise.repeat,
              //         ))
              //     .toList(),
              itemCount: _userExercises.length,
              itemBuilder: (BuildContext, int index) {
                return ExerciseItem(
                  dayExercises[index].id,
                  dayExercises[index].title,
                  dayExercises[index].weight,
                  dayExercises[index].set,
                  dayExercises[index].repeat,
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
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
                          decoration:
                              InputDecoration(labelText: 'Название упражнения'),
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
                        FlatButton(
                          child: Text(
                            'Добавить упражнение',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          // color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).textTheme.button.color,
                          onPressed: () =>
                              {/*_addExercise(tilteExerciseController.text,)*/},
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import '../new_exercise.dart';

import '../dummy.dart';
import '../exercise_item.dart';

class ExercisesScreen extends StatefulWidget {
  static const routeName = '/exercise';
  final Function addExercise;

  const ExercisesScreen({Key key, this.addExercise}) : super(key: key);
  @override
  State<ExercisesScreen> createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  // String dayId;
  final List<Exercise> _userExercise = DUMMY_EXERCISES;

  void _addExercise(
    String exTitle,
    double exWeight,
    int exSet,
    int exRepeat,
  ) {
    final newEx = Exercise(
      title: exTitle,
      weight: exWeight,
      set: exSet,
      repeat: exRepeat,
      id: exTitle,
    );
    setState(() {
      _userExercise.add(newEx);
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
    widget.addExercise(
      enteredExerciseTitle,
      enteredWeight,
      enteredSet,
      enteredRepeat,
    );

    Navigator.of(context).pop();
  }

  // void _startAddNewExercise(BuildContext ctx) {
  //   showModalBottomSheet(
  //     context: ctx,
  //     builder: (context) {
  //       return GestureDetector(
  //         onTap: () {},
  //         child: NewExercise(_addNExercise),
  //         behavior: HitTestBehavior.opaque,
  //       );
  //     },
  //   );
  // }

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
      body: _userExercise.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Добавьте упражнения',
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
          :
          // ListView(
          //     padding: const EdgeInsets.all(5),
          //     children: _userExercise
          //         .map((exercise) => ExerciseItem(
          //               exercise.id,
          //               exercise.title,
          //               exercise.weight,
          //               exercise.set,
          //               exercise.repeat,
          //             ))
          //         .toList(),
          //   ),
          ListView.builder(
              itemCount: dayExercises.length,
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
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).secondaryHeaderColor,
      //   onPressed: () => {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return SingleChildScrollView(
      //           child: Card(
      //             elevation: 5,
      //             child: Container(
      //               padding: EdgeInsets.only(
      //                 top: 10,
      //                 left: 10,
      //                 right: 10,
      //                 bottom: MediaQuery.of(context).viewInsets.bottom + 10,
      //               ),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: <Widget>[
      //                   TextField(
      //                     decoration:
      //                         InputDecoration(labelText: 'Название упражнения'),
      //                     controller: tilteExerciseController,
      //                     onSubmitted: (_) => _submitData(),
      //                   ),
      //                   TextField(
      //                     decoration: InputDecoration(labelText: 'Вес'),
      //                     controller: weightExerciseController,
      //                     keyboardType: TextInputType.number,
      //                     onSubmitted: (_) => _submitData(),
      //                   ),
      //                   TextField(
      //                     decoration: InputDecoration(labelText: 'Подходы'),
      //                     controller: setExerciseController,
      //                     keyboardType: TextInputType.number,
      //                     onSubmitted: (_) => _submitData(),
      //                   ),
      //                   TextField(
      //                     decoration: InputDecoration(labelText: 'Повторы'),
      //                     controller: repeatExerciseController,
      //                     keyboardType: TextInputType.number,
      //                     onSubmitted: (_) => _submitData(),
      //                   ),
      //                   RaisedButton(
      //                     child: const Text('Добавить упражнение'),
      //                     color: Theme.of(context).primaryColor,
      //                     textColor: Theme.of(context).textTheme.button.color,
      //                     onPressed: () => _addExercise(
      //                       tilteExerciseController.text,
      //                       double.parse(weightExerciseController.text),
      //                       int.parse(setExerciseController.text),
      //                       int.parse(repeatExerciseController.text),
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //         );
      //       },
      //     )
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

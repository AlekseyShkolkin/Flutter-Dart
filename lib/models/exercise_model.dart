import 'package:flutter/foundation.dart';

class Exercise {
  final String id;
  final List<String> days;
  final String title;
  final double weight;
  final int set;
  final int repeat;
  final String imageUrl;

  Exercise({
    @required this.id,
    @required this.days,
    @required this.title,
    @required this.weight,
    @required this.set,
    @required this.repeat,
    @required this.imageUrl,
  });
}

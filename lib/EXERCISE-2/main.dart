import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:week5/EXERCISE-2/exercise2.dart';


import 'counter_model.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterModel(),
      child: const MyApp(),
    ),
  );
}

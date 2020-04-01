import 'package:flutter/material.dart';
import 'package:tracker/logic/timer_bloc.dart';
import 'package:tracker/screen/timer_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timerBloc = TimerBloc();

    return MaterialApp(
      title: 'Tracker',
      home: TimerScreen(timerBloc: timerBloc),
    );
  }
}
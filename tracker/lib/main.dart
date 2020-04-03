import 'package:flutter/material.dart';
import 'package:tracker/logic/timer_bloc.dart';
import 'package:tracker/ui/res/colors.dart';
import 'package:tracker/ui/screen/timer_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timerBloc = TimerBloc();

    return MaterialApp(
      title: 'Tracker',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: TimerScreen(timerBloc: timerBloc),
    );
  }
}